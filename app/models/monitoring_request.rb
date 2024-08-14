# == Schema Information
#
# Table name: monitoring_requests
#
#  id         :bigint           not null, primary key
#  end_time   :datetime         not null
#  start_time :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  service_id :bigint           not null
#  user_id    :bigint
#
# Indexes
#
#  index_monitoring_requests_on_service_id  (service_id)
#  index_monitoring_requests_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (service_id => services.id)
#  fk_rails_...  (user_id => users.id)
#
class MonitoringRequest < ApplicationRecord
  belongs_to :service
  belongs_to :user, optional: true

  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time
  validate :cant_overlap

  # Should return the monitoring requests of the week of the given date for the same year
  scope :by_week, ->(date) { where(start_time: date.beginning_of_week..date.end_of_week).where(start_time: date.beginning_of_year..date.end_of_year) }

  def set_end_time
    self.end_time = start_time + 1.hour
  end

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "Must be after the start time")
    end
  end

  def cant_overlap
    return if service.nil?

    if service.monitoring_requests.where(start_time: start_time..end_time).any?
      errors.add(:start_time, "Can't overlap with another monitoring request")
    end
  end
end
