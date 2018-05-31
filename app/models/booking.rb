# == Schema Information
#
# Table name: bookings
#
#  id         :bigint(8)        not null, primary key
#  end_time   :datetime         not null
#  start_time :datetime         not null
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

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :device

  validates :start_time, :end_time, presence: true
end
