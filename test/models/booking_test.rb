# == Schema Information
#
# Table name: bookings
#
#  id         :bigint(8)        not null, primary key
#  end_time   :datetime
#  start_time :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  device_id  :bigint(8)
#  user_id    :bigint(8)
#
# Indexes
#
#  index_bookings_on_device_id  (device_id)
#  index_bookings_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (device_id => devices.id)
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
