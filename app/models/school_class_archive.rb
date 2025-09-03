class SchoolClassArchive < ApplicationRecord
  belongs_to :school_class

  validates :label, presence: true
  validates :label, uniqueness: { scope: :school_class_id }
  validates :archived_at, presence: true
  validates :data, presence: true
end
