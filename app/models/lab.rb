# == Schema Information
#
# Table name: labs
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lab < ApplicationRecord
  has_many :users
  has_many :devices
  has_many :bookings, through: :devices

end
