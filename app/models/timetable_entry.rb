class TimetableEntry < ApplicationRecord
  belongs_to :assignment, class_name: 'SchoolClassSubject'
  belongs_to :period

  delegate :school_class, :school_class_id, :teacher, :teacher_id, :subject, :subject_id,
           to: :assignment

  enum weekday: { monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5 }

  validates :weekday, presence: true
  validate  :assignment_has_teacher
  validate  :no_overlap_for_class
  validate  :no_overlap_for_teacher

  def assignment_has_teacher
    return unless assignment && assignment.teacher_id.blank?

    errors.add(:assignment_id, 'must have a teacher assigned before scheduling')
  end

  def no_overlap_for_class
    return if assignment.nil? || weekday.blank? || period_id.blank?

    clash = TimetableEntry
            .joins(:assignment)
            .where(weekday: weekday, period_id: period_id)
            .where.not(id: id)
            .exists?(school_class_subjects: { school_class_id: assignment.school_class_id })
    errors.add(:base, 'This class already has a lesson in this slot') if clash
  end

  def no_overlap_for_teacher
    return if assignment.nil? || weekday.blank? || period_id.blank? || assignment.teacher_id.blank?

    clash = TimetableEntry
            .joins(:assignment)
            .where(weekday: weekday, period_id: period_id)
            .where.not(id: id)
            .exists?(school_class_subjects: { teacher_id: assignment.teacher_id })
    errors.add(:base, 'Teacher already has a lesson in this slot') if clash
  end

  def as_json(*)
    {
      id: id,
      weekday: weekday,
      period_id: period_id,
      period_label: period.label,
      class_id: school_class_id,
      class_name: school_class.name,
      subject_id: subject_id,
      subject_name: subject.name,
      teacher_id: teacher_id,
      teacher_name: teacher.name,
      assignment_id: assignment_id
    }
  end
end
