class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :assignment, class_name: 'SchoolClassSubject'
  belongs_to :period

  enum status: { present: 0, absent: 1 }

  validates :date, presence: true
  validates :status, presence: true

  validates :user_id, uniqueness: {
    scope: %i[assignment_id period_id date],
    message: :already_recorded_for_slot
  }

  validate :user_belongs_to_assignment_class
  validate :assignment_scheduled_in_timetable

  private

  def user_belongs_to_assignment_class
    return if user.nil? || assignment.nil?

    return if user.school_class_id == assignment.school_class_id

    errors.add(:user_id, "does not belong to the assignment's class")
  end

  def assignment_scheduled_in_timetable
    return if date.nil? || period.nil? || assignment.nil?

    if date.saturday? || date.sunday?
      errors.add(:date, 'must be a weekday (Monday to Friday)')
      return
    end

    weekday = date.wday

    exists = TimetableEntry.exists?(
      assignment_id: assignment.id,
      period_id: period.id,
      weekday: weekday
    )

    return if exists

    errors.add(:base, 'No scheduled class for this assignment and period on the given date')
  end
end
