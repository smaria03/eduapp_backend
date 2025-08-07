class SchoolClass < ApplicationRecord
  has_many :students, class_name: 'User', dependent: :nullify
  has_many :school_class_subjects, dependent: :destroy
  has_many :subjects, through: :school_class_subjects

  validates :name, presence: true, uniqueness: true

  VALID_CLASS_NAME_REGEX = /\A(1[0-2]|[1-9])[A-G]\z/.freeze

  validates :name, format: {
    with: VALID_CLASS_NAME_REGEX,
    message: :invalid_class_format
  }
end
