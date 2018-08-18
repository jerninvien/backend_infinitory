# == Schema Information
#
# Table name: labs
#
#  id         :bigint(8)        not null, primary key
#  institute  :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lab < ApplicationRecord
  # ADD DEFAULT SCOPE TO ALWAYS INCLUDE LAB'S USERS, DEVICES, INVITECODES, BOOKINGS?
  # ADD CONCERN OR MODULE / MIXIN FOR SHARED METHOD TO CALCULATE LAB DEVICE'S '% BOOKING TIME'?

  has_many :users, index_errors: true, inverse_of: :lab, dependent: :destroy
  accepts_nested_attributes_for :users

  has_many :invite_codes, through: :users
  has_many :devices, dependent: :destroy
  has_many :bookings, through: :devices, dependent: :destroy

  validates :name,
    presence: true,
    length: {
      in: 1..40,
      message: "should be between 2 and 40 characters long"
    }

  validates :institute,
    allow_blank: true,
    length: {
      in: 1..80,
      message: "name should be between 2 and 80 characters long"
    }


  protected

  before_create :create_first_user_and_invite_codes
  def create_first_user_and_invite_codes
    puts 'create_first_user'
    first_user = self.users.build({
      name: self.name,
      admin: true
      })

    self.name = self.name + " Group"
  end

  after_create :generate_initial_invite_codes
  def generate_initial_invite_codes
    InviteCode.where(user: nil).sample(5).each do |ic|
      ic.user = self.users.first
      ic.save!
    end
  end

end
