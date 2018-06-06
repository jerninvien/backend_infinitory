# == Schema Information
#
# Table name: invite_codes
#
#  id         :bigint(8)        not null, primary key
#  code       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lab_id     :bigint(8)
#  user_id    :bigint(8)
#
# Indexes
#
#  index_invite_codes_on_code     (code) UNIQUE
#  index_invite_codes_on_lab_id   (lab_id)
#  index_invite_codes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (lab_id => labs.id)
#  fk_rails_...  (user_id => users.id)
#

class InviteCode < ApplicationRecord
  belongs_to :lab, inverse_of: :invite_codes
  belongs_to :user, inverse_of: :invite_codes

  validates :lab, :user, presence: true

  validates :code, uniqueness: true, length: { maximum: 4 }

  protected

  before_create :gen_unique_code
  def gen_unique_code
    puts 'gen_unique_code'
    self.code = loop do
      invite_code = rand(10 ** 4)
      break invite_code unless InviteCode.exists?(code: invite_code)
    end
  end
end
