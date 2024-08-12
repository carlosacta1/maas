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
  has_many :service_user_monitors, dependent: :destroy
  has_many :users, through: :service_user_monitors

  validates :name, presence: true
  validates :description, presence: true
end
