class LearningMaterial < ApplicationRecord
  belongs_to :assignment, class_name: 'SchoolClassSubject'
  delegate :teacher_id, to: :assignment
  has_one_attached :file

  validate :file_attached_and_valid_type

  private

  def file_attached_and_valid_type
    unless file.attached?
      errors.add(:file, 'must be attached')
      return
    end

    allowed_types = %w[application/pdf image/png image/jpg image/jpeg
                       application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
                       application/vnd.ms-excel application/msword
                       application/vnd.openxmlformats-officedocument.wordprocessingml.document
                       application/zip]

    return if allowed_types.include?(file.content_type)

    errors.add(:file, 'must be a PDF, image, Word, Excel or ZIP')
  end
end
