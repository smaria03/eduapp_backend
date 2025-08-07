class SchoolClassSubject < ApplicationRecord
  belongs_to :school_class
  belongs_to :subject

  validates :school_class_id, uniqueness: { scope: :subject_id }
end
