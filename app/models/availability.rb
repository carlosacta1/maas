# == Schema Information
#
# Table name: availabilities
#
#  id                      :bigint           not null, primary key
#  end_day                 :string           default("Friday"), not null
#  end_time                :time             default(Sat, 01 Jan 2000 17:00:00.000000000 UTC +00:00), not null
#  start_day               :string           default("Monday"), not null
#  start_time              :time             default(Sat, 01 Jan 2000 08:00:00.000000000 UTC +00:00), not null
#  temporarily_unavailable :boolean          default(FALSE), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :bigint           not null
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
  before_save :sanitize_days
  belongs_to :user

  validates :start_day, :end_day, :start_time, :end_time, presence: true
  validate :end_day_after_or_equal_to_start_day
  validate :end_time_after_start_time

  def overlaps?(datetime)
    day_name = datetime.strftime('%A')
    time = datetime.hour

    if day_in_range?(day_name) && time_in_range?(time)
      return true
    else
      return false
    end
  end

  private

  def day_in_range?(day_name)
    start_day_index = Date::DAYNAMES.index(start_day)
    end_day_index = Date::DAYNAMES.index(end_day)
    day_index = Date::DAYNAMES.index(day_name)

    day_index >= start_day_index && day_index <= end_day_index
  end

  def time_in_range?(time)
    time >= start_time.hour && time <= end_time.hour
  end

  def end_day_after_or_equal_to_start_day
    return if start_day.blank? || end_day.blank?

    if Date::DAYNAMES.index(end_day) < Date::DAYNAMES.index(start_day)
      errors.add(:end_day, "Must be after the start day")
    end
  end

  def end_time_after_start_time
    return if start_time.blank? || end_time.blank?

    if start_day == end_day && end_time <= start_time
      errors.add(:end_time, "must be after the start time on the same day")
    end
  end

  def sanitize_days
    self.start_day = start_day.capitalize
    self.end_day = end_day.capitalize
  end
end
