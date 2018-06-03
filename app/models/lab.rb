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
  has_many :bookings,
    through: :devices,
    dependent: :destroy

  has_many :devices, dependent: :destroy
  has_many :invite_codes, dependent: :destroy
  has_many :users, dependent: :destroy

  validates :name,
    presence: true,
    length: {
      in: 2..60,
      message: 'Lab names should be between 2 and 60 characters long'
    }


  before_create :set_lab_name

  after_create :generate_lab_invite_codes


  protected

  def set_lab_name
    puts 'set_lab_name'
    self.name = self.users.first.name if self.users.first
    errors.add(:base, 'Needs first user')
  end

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
