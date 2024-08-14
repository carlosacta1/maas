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
require "test_helper"

class AvailabilityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
