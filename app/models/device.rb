# == Schema Information
#
# Table name: devices
#
#  id         :bigint(8)        not null, primary key
#  disabled   :boolean          default(FALSE), not null
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

class Device < ApplicationRecord
  # ADD DEFAULT SCOPE TO ALWAYS INCLUDE DEVICE'S, USERS AND BOOKINGS?
  # ADD CONCERN OR MODULE / MIXIN FOR SHARED METHOD TO CALCULATE DEVICE'S % BOOKING TIME?

  belongs_to :lab

  has_many :bookings, inverse_of: :device
  has_many :users, through: :bookings

  # ADD CURRENTLY_ACTIVE? METHOD

end
