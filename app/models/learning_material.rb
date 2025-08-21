class LearningMaterial < ApplicationRecord
  belongs_to :assignment, class_name: 'SchoolClassSubject'
  delegate :teacher_id, to: :assignment
  has_one_attached :file

  validates :title, presence: true
end
