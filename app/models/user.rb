# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  invited_by :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lab_id     :bigint(8)
#
# Indexes
#
#  index_users_on_lab_id  (lab_id)
#
# Foreign Keys
#
#  fk_rails_...  (lab_id => labs.id)
#

class User < ApplicationRecord
  belongs_to :lab

  has_many :bookings
  has_many :devices, through: :bookings
end