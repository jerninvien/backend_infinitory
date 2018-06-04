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
  accepts_nested_attributes_for :users
  has_many :users,
    inverse_of: :lab,
    dependent: :destroy

  has_many :invite_codes,
    inverse_of: :lab,
    dependent: :destroy

  has_many :devices, dependent: :destroy

  has_many :bookings,
    through: :devices,
    dependent: :destroy

  validates :name,
    presence: true,
    length: {
      in: 2..60,
      message: 'Lab names should be between 2 and 60 characters long'
    }

  validates :institute,
    length: {
      in: 4..80,
      message: 'Institute name should be between 4 and 40 characters long'
    }

  protected

  before_create :update_name
  def update_name
    puts 'create_first_user'
    self.name = self.name + " Group"
  end

  after_create :generate_lab_invite_codes
  def generate_lab_invite_codes
    puts 'generate_lab_invite_codes'
    5.times do
      InviteCode.create!(
        lab: self,
        user: self.users.first,
      )
    end
  end
end
