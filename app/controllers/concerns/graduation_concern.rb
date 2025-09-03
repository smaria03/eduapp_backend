module GraduationConcern
  extend ActiveSupport::Concern

  private

  def fetch_graduation_data(school_class, students)
    assignments = SchoolClassSubject.where(school_class_id: school_class.id)
    assignment_ids = assignments.ids
    student_ids = students.ids

    {
      students: serialize_students(students),
      assignments: serialize_assignments(assignments),
      grades: fetch_grades(student_ids),
      homeworks: fetch_homeworks(assignment_ids),
      homework_submissions: fetch_homework_submissions(assignment_ids),
      quizzes: fetch_quizzes(assignment_ids),
      quiz_submissions: fetch_quiz_submissions(assignment_ids),
      quiz_answers: fetch_quiz_answers(assignment_ids),
      materials: fetch_materials(assignment_ids),
      attendances: fetch_attendances(assignment_ids),
      timetable_entries: fetch_timetable(assignment_ids)
    }
  end

  def serialize_students(students)
    students.as_json(only: %i[id name email])
  end

  def serialize_assignments(assignments)
    assignments.map do |a|
      {
        subject_id: a.subject_id,
        subject_name: a.subject.name,
        teacher_id: a.teacher_id,
        teacher_name: a.teacher&.name
      }
    end
  end

  def fetch_grades(student_ids)
    Grade.where(student_id: student_ids).as_json
  end

  def fetch_homeworks(assignment_ids)
    Homework.where(assignment_id: assignment_ids).as_json
  end

  def fetch_homework_submissions(assignment_ids)
    HomeworkSubmission
      .where(homework_id: Homework
                            .where(assignment_id: assignment_ids).select(:id)).as_json
  end

  def fetch_quizzes(assignment_ids)
    Quiz::Quiz.where(assignment_id: assignment_ids).as_json
  end

  def fetch_quiz_submissions(assignment_ids)
    Quiz::QuizSubmission
      .where(quiz_id: Quiz::Quiz
                        .where(assignment_id: assignment_ids).select(:id)).as_json
  end

  def fetch_quiz_answers(assignment_ids)
    quiz_ids = Quiz::Quiz.where(assignment_id: assignment_ids).select(:id)
    submission_ids = Quiz::QuizSubmission.where(quiz_id: quiz_ids).select(:id)
    Quiz::QuizAnswer.where(quiz_submission_id: submission_ids).as_json
  end

  def fetch_materials(assignment_ids)
    LearningMaterial.where(assignment_id: assignment_ids).as_json
  end

  def fetch_attendances(assignment_ids)
    Attendance.where(assignment_id: assignment_ids).as_json
  end

  def fetch_timetable(assignment_ids)
    TimetableEntry.where(assignment_id: assignment_ids).as_json
  end

  def create_archive(school_class, original_name, data, label)
    SchoolClassArchive.create!(
      school_class: school_class,
      label: label,
      archived_at: Time.current,
      data: {
        class_name: original_name,
        **data
      }
    )
  end

  def cleanup_and_promote(school_class, original_name, label, students)
    assignment_ids = SchoolClassSubject.where(school_class_id: school_class.id).pluck(:id)

    delete_assignment_related_data(assignment_ids, students)

    if original_name.match?(/\A12[A-G]\z/)
      archive_class(school_class, original_name, label, students)
    else
      promote_class(school_class, original_name)
    end
  end

  def delete_assignment_related_data(assignment_ids, students)
    TimetableEntry.where(assignment_id: assignment_ids).delete_all
    Attendance.where(assignment_id: assignment_ids).delete_all
    delete_quizzes(assignment_ids)
    HomeworkSubmission
      .where(homework_id: Homework
                            .where(assignment_id: assignment_ids).select(:id)).delete_all
    Homework.where(assignment_id: assignment_ids).delete_all
    LearningMaterial.where(assignment_id: assignment_ids).delete_all
    Grade.where(student_id: students.pluck(:id)).delete_all
    SchoolClassSubject.where(id: assignment_ids).delete_all
  end

  def delete_quizzes(assignment_ids)
    Quiz::Quiz.where(assignment_id: assignment_ids).find_each do |quiz|
      Quiz::QuizQuestion.where(quiz_id: quiz.id).find_each do |question|
        Quiz::QuizOption.where(quiz_question_id: question.id).delete_all
      end
      Quiz::QuizAnswer
        .where(quiz_submission_id: Quiz::QuizSubmission.where(quiz_id: quiz.id)).delete_all
      Quiz::QuizSubmission.where(quiz_id: quiz.id).delete_all
      Quiz::QuizQuestion.where(quiz_id: quiz.id).delete_all
    end
    Quiz::Quiz.where(assignment_id: assignment_ids).delete_all
  end

  def archive_class(school_class, original_name, label, students)
    archive_name = "#{original_name}_#{label}"
    school_class.update!(archived: true, name: archive_name)
    students.find_each { |student| student.update!(graduated: true) }
  end

  def promote_class(school_class, original_name)
    new_name = increment_class_name(original_name)
    school_class.update!(name: new_name)
  end

  def increment_class_name(name)
    match = name.match(/(\d+)([A-Z])/)
    if match
      number = match[1].to_i + 1
      letter = match[2]
      "#{number}#{letter}"
    else
      name
    end
  end
end
