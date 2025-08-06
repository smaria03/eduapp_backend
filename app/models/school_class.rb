class SchoolClass < ApplicationRecord
  has_many :students, class_name: 'User', dependent: :nullify

  validates :name, presence: true, uniqueness: true

  VALID_CLASS_NAME_REGEX = /\A(1[0-2]|[1-9])[A-G]\z/.freeze

  validates :name, format: {
    with: VALID_CLASS_NAME_REGEX,
    message: :invalid_class_format
  }
end
