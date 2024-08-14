# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  jti                    :string           not null
#  last_name              :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_jti                   (jti) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
          :jwt_authenticatable, jwt_revocation_strategy: self
  
  has_many :availabilities, dependent: :destroy
  has_many :monitoring_requests
  has_many :services, through: :monitoring_requests


  def generate_availability_weeks(future_weeks_count = 5)
    past_weeks = availabilities.group_by { |mr| [mr.start_time.to_date.cweek, mr.start_time.year] }
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

  def jwt_payload
    super
  end
end
