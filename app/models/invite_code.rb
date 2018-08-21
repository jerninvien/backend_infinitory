# == Schema Information
#
# Table name: invite_codes
#
#  id         :bigint(8)        not null, primary key
#  code       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#
# Indexes
#
#  index_invite_codes_on_code     (code) UNIQUE
#  index_invite_codes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class InviteCode < ApplicationRecord
  belongs_to :user, inverse_of: :invite_codes, optional: true
  # validates :lab, :user, presence: true
  validates :code, uniqueness: true, length: { is: 4 }


  def reset_info
    puts 'InviteCode reset_info'
    self.user = nil
    save!
  end

  protected
    def self.claim_invite_code(user)
      if user.lab.invite_codes.count < 5
        InviteCode.where(user: nil).sample do |ic|
          ic.user = user
          ic.save!
        end
      else
        user.errors.add(:error, "Use your lab's pre-existing invite codes")
        return false
      end
    end
end
