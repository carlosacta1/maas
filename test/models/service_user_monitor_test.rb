# == Schema Information
#
# Table name: service_user_monitors
#
#  id         :bigint           not null, primary key
#  schedule   :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  service_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_service_user_monitors_on_service_id  (service_id)
#  index_service_user_monitors_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (service_id => services.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ServiceUserMonitorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
