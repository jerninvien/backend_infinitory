# == Schema Information
#
# Table name: invite_codes
#
#  id                  :bigint(8)        not null, primary key
#  code                :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  lab_id              :bigint(8)
#  redeemed_by_user_id :integer
#  user_id             :bigint(8)
#
# Indexes
#
#  index_invite_codes_on_lab_id   (lab_id)
#  index_invite_codes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (lab_id => labs.id)
#  fk_rails_...  (user_id => users.id)
#

class InviteCode < ApplicationRecord
  belongs_to :lab
  belongs_to :user

  validates :lab, :user, presence: true

  validates :lab,
    uniqueness: {
      scope: :code,
      message: 'Invite Code must be unique'
    }

  before_create :generate_invite_code

  protected

  def generate_invite_code
    puts 'generate_invite_code'
    self.code = loop do
      invite_code = rand(10 ** 4)
      break invite_code unless InviteCode.exists?(code: invite_code)
    end
  end
end
