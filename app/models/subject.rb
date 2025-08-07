class Subject < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :school_class_subjects, dependent: :destroy
  has_many :school_classes, through: :school_class_subjects
end
