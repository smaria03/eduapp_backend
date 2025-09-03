class SchoolClass < ApplicationRecord
  has_many :students,
           -> { where(role: 'student') },
           class_name: 'User',
           inverse_of: :school_class,
           dependent: :nullify
  has_many :school_class_subjects, dependent: :destroy
  has_many :subjects, through: :school_class_subjects

  default_scope { where(archived: false) }

  validates :name, presence: true, uniqueness: true

  VALID_CLASS_NAME_REGEX = /\A(1[0-2]|[1-9])[A-G]\z/.freeze

  validates :name, format: {
    with: VALID_CLASS_NAME_REGEX,
    message: :invalid_class_format
  }, unless: :archived?
end
