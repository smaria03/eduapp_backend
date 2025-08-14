class Grade < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :subject
  belongs_to :teacher, class_name: 'User'

  validates :value, presence: true, inclusion: { in: 1..10 }
end
