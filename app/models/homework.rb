class Homework < ApplicationRecord
  belongs_to :assignment, class_name: 'SchoolClassSubject', inverse_of: :homeworks
  has_many :submissions, class_name: 'HomeworkSubmission', dependent: :destroy

  validates :title, :description, :deadline, presence: true
  validate :deadline_cannot_be_in_the_past

  private

  def deadline_cannot_be_in_the_past
    return if deadline.blank?

    return unless deadline < Date.current

    errors.add(:deadline, "can't be in the past")
  end
end
