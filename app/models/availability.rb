# == Schema Information
#
# Table name: availabilities
#
#  id         :bigint           not null, primary key
#  end_time   :datetime         not null
#  start_time :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_availabilities_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Availability < ApplicationRecord
  belongs_to :user

  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time
  validate :cant_overlap

  scope :by_week, ->(date) { where(start_time: date.beginning_of_week..date.end_of_week) }

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
    return if user.nil?

    if user.availabilities.where(start_time: start_time..end_time).any?
      errors.add(:start_time, "Can't overlap with another monitoring request")
    end
  end
end
