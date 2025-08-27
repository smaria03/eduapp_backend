class Homework < ApplicationRecord
  belongs_to :assignment, class_name: 'SchoolClassSubject', inverse_of: :homeworks

  validates :title, :description, :deadline, presence: true
end
