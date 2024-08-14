# == Schema Information
#
# Table name: services
#
#  id          :bigint           not null, primary key
#  description :text             default(""), not null
#  name        :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Service < ApplicationRecord
  has_many :monitoring_requests, dependent: :destroy
  has_many :users, through: :monitoring_requests

  validates :name, presence: true
  validates :description, presence: true

  def generate_monitoring_weeks(future_weeks_count = 5)
    past_weeks = monitoring_requests.group_by { |mr| [mr.start_time.to_date.cweek, mr.start_time.year] }
    past_weeks = past_weeks.map do |(week_number, year), requests|
      {
        week: week_number,
        year: year,
        start_date: requests.first.start_time.beginning_of_week,
        end_date: requests.first.end_time.end_of_week,
        friendly_name: "del #{requests.first.start_time.beginning_of_week.strftime('%d/%m/%Y')} al #{requests.first.end_time.end_of_week.strftime('%d/%m/%Y')}",
        friendly_week_year: "Semana #{week_number} del #{year}"
      }
    end
  
    future_weeks = (0..future_weeks_count).map do |i|
      date = Date.today + i.weeks
      {
        week: date.cweek,
        year: date.year,
        start_date: date.beginning_of_week,
        end_date: date.end_of_week,
        friendly_name: "del #{date.beginning_of_week.strftime('%d/%m/%Y')} al #{date.end_of_week.strftime('%d/%m/%Y')}",
        friendly_week_year: "Semana #{date.cweek} del #{date.year}"
      }
    end
  
    weeks = (past_weeks + future_weeks).uniq { |week| [week[:week], week[:year]] }
    weeks.sort_by { |week| [week[:year], week[:week]] }
  end
end
