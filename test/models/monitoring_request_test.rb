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
require "test_helper"

class MonitoringRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
