module Api
  class StudentReportsController < ApplicationController
    before_action :authorize_student!

    def show
      student = current_user
      school_class = student.school_class
      assignments = SchoolClassSubject.where(school_class: school_class)

      per_subject = assignments.map do |assignment|
        {
          subject: assignment.subject.name,
          average: subject_average(student, assignment.subject_id),
          absences: absences_for(student, assignment.subject_id),
          homeworks: homework_stats(student, assignment),
          quizzes: quiz_scores(student, assignment)
        }
      end

      overall_avg = Grade.where(student: student).average(:value)&.round(2)
      position = class_ranking_position(student)

      render json: {
        student_name: student.name,
        class_name: school_class.name,
        overall_average: overall_avg,
        class_position: position,
        total_absences: Attendance.where(user_id: student.id).count,
        subjects: per_subject
      }
    end

    private

    def subject_average(student, subject_id)
      Grade.where(student: student, subject_id: subject_id).average(:value)&.round(2)
    end

    def absences_for(student, subject_id)
      assignment_ids = SchoolClassSubject
                       .where(school_class_id: student.school_class_id, subject_id: subject_id)
                       .pluck(:id)

      Attendance
        .where(user_id: student.id, assignment_id: assignment_ids)
        .count
    end

    def homework_stats(student, assignment)
      homeworks = Homework.where(assignment_id: assignment.id)
      submitted = HomeworkSubmission.where(student: student, homework_id: homeworks.pluck(:id))

      {
        submitted: submitted.count,
        total: homeworks.count
      }
    end

    def quiz_scores(student, assignment)
      quizzes = Quiz::Quiz.where(assignment_id: assignment.id)
      submissions = Quiz::QuizSubmission.where(student: student, quiz_id: quizzes.pluck(:id))

      submissions.map do |submission|
        {
          quiz_title: submission.quiz.title,
          score: submission.final_score
        }
      end
    end

    def class_ranking_position(student)
      classmates = student.school_class.students

      averages = classmates.to_h do |s|
        [s.id, Grade.where(student_id: s.id).average(:value)&.round(2) || 0]
      end

      sorted = averages.sort_by { |_id, avg| -avg }.map(&:first)
      sorted.index(student.id) + 1
    end

    def authorize_student!
      return if current_user&.role == 'student'

      render json: { error: 'Unauthorized: Students only' }, status: :unauthorized
    end
  end
end
