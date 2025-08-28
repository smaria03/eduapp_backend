class HomeworkSubmission < ApplicationRecord
  belongs_to :homework
  belongs_to :student, class_name: 'User'
  has_one_attached :file

  validates :student_id,
            uniqueness: { scope: :homework_id, message: :already_submitted }
  validate :file_attached_and_valid_type
  validates :grade,
            numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 },
            allow_nil: true

  private

  def file_attached_and_valid_type
    unless file.attached?
      errors.add(:file, 'must be attached')
      return
    end

    allowed_types = %w[
      application/pdf
      image/png
      image/jpg
      image/jpeg
      application/msword
      application/vnd.openxmlformats-officedocument.wordprocessingml.document
      application/zip
    ]

    return if allowed_types.include?(file.content_type)

    errors.add(:file, 'must be a PDF, image, Word or ZIP')
  end
end
