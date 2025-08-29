module Api
  class ClassReportsController < ApplicationController
    before_action :authorize_teacher!

    def show
      school_class = SchoolClass.find(params[:id])
      unless teaches_class?(current_user, school_class)
        render json: { error: 'Unauthorized: You don’t teach this class' },
               status: :unauthorized and return
      end

      students = school_class.students
      subjects = SchoolClassSubject.where(school_class: school_class, teacher: current_user)

      report = {
        class_name: school_class.name,
        students_count: students.count,
        subjects: subjects.map do |assignment|
          {
            subject: assignment.subject.name,
            grades: average_grades(assignment),
            attendance: attendance_stats(assignment),
            homeworks: homework_stats(assignment),
            quizzes: quiz_stats(assignment)
          }
        end
      }

      render json: report
    end

    private

    def authorize_teacher!
      return if current_user&.role == 'teacher'

      render json: { error: 'Unauthorized: Teachers only' }, status: :unauthorized
    end

    def teaches_class?(teacher, school_class)
      SchoolClassSubject.exists?(school_class: school_class, teacher: teacher)
    end

    def average_grades(assignment)
      students = assignment.school_class.students

      grades = Grade
               .where(subject_id: assignment.subject_id, student_id: students.pluck(:id))
               .group(:student_id)
               .average(:value)

      students_with_grades = students.map do |student|
        {
          name: student.name,
          average: grades[student.id]&.round(2)
        }
      end

      overall_average = begin
        grades.values.compact.sum / grades.values.compact.size.to_f
      rescue StandardError
        nil
      end

      {
        per_student: students_with_grades,
        class_average: overall_average&.round(2)
      }
    end

    def attendance_stats(assignment)
      {
        present: Attendance.where(assignment_id: assignment.id, status: 'present').count,
        absent: Attendance.where(assignment_id: assignment.id, status: 'absent').count
      }
    end

    def homework_stats(assignment)
      homeworks = Homework.where(assignment_id: assignment.id)
      students = assignment.school_class.students

      homeworks.map do |homework|
        submissions = HomeworkSubmission.where(homework_id: homework.id)
        submitted_count = submissions.distinct.count(:student_id)
        avg_grade = submissions.average(:grade)

        {
          title: homework.title,
          submitted: "#{submitted_count}/#{students.count}",
          average_grade: avg_grade&.round(2)
        }
      end
    end

    def quiz_stats(assignment)
      quizzes = Quiz::Quiz.where(assignment_id: assignment.id)
      students = assignment.school_class.students

      quizzes.map do |quiz|
        submissions = Quiz::QuizSubmission.where(quiz_id: quiz.id)
        submitted_count = submissions.distinct.count(:student_id)
        avg_score = submissions.average(:final_score)

        {
          title: quiz.title,
          submitted: "#{submitted_count}/#{students.count}",
          average_score: avg_score&.round(2)
        }
      end
    end
  end
end
