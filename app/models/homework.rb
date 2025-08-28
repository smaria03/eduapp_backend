class Homework < ApplicationRecord
  belongs_to :assignment, class_name: 'SchoolClassSubject', inverse_of: :homeworks
  has_many :submissions, class_name: 'HomeworkSubmission', dependent: :destroy

  validates :title, :description, :deadline, presence: true
end
