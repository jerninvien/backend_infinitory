# == Schema Information
#
# Table name: devices
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lab_id     :bigint(8)
#
# Indexes
#
#  index_devices_on_lab_id  (lab_id)
#
# Foreign Keys
#
#  fk_rails_...  (lab_id => labs.id)
#

require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
