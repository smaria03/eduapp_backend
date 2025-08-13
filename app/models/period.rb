class Period < ApplicationRecord
  validates :start_time, :end_time, :label, presence: true
  validate  :end_after_start
  before_validation :build_label

  private

  def end_after_start
    return if start_time.blank? || end_time.blank?

    errors.add(:end_time, 'must be after start_time') if end_time <= start_time
  end

  def build_label
    return if start_time.blank? || end_time.blank?

    self.label = "#{start_time.strftime('%H:%M')}–#{end_time.strftime('%H:%M')}"
  end
end
