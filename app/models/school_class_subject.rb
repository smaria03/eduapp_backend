class SchoolClassSubject < ApplicationRecord
  belongs_to :school_class
  belongs_to :subject
  belongs_to :teacher, class_name: 'User', optional: true

  validates :school_class_id, uniqueness: { scope: :subject_id }
  validates :subject_id,
            uniqueness: { scope: :school_class_id }
  validate :teacher_has_teacher_role, if: -> { teacher_id.present? }

  private

  def teacher_has_teacher_role
    errors.add(:teacher, 'must have teacher role') unless teacher&.role == 'teacher'
  end
end
