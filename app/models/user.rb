# == Schema Information
#
# Table name: users
#
#  id          :bigint(8)        not null, primary key
#  admin       :boolean          default(FALSE), not null
#  api_key     :string
#  approved_by :string
#  invited_by  :string
#  name        :string           not null
#  role        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lab_id      :bigint(8)
#
# Indexes
#
#  index_users_on_api_key  (api_key) UNIQUE
#  index_users_on_lab_id   (lab_id)
#
# Foreign Keys
#
#  fk_rails_...  (lab_id => labs.id)
#

class User < ApplicationRecord
  # ADD DEFAULT SCOPE TO ALWAYS INCLUDE DEVICES, INVITECODES, BOOKINGS?
  # ADD CONCERN OR MODULE / MIXIN FOR SHARED METHOD TO CALCULATE USER DEVICE'S % BOOKING TIME?

  belongs_to :lab, inverse_of: :users
  has_many :invite_codes, inverse_of: :user, dependent: :destroy

  has_many :bookings, index_errors: true, inverse_of: :user
  accepts_nested_attributes_for :bookings

  has_many :devices, through: :bookings

  validates :name,
    presence: true,
    length: {
      in: 1..40,
      message: "should be between 2 and 40 characters long"
    }

  # Assign an API key on create
  # SHOULD THIS BE ENCRYPRED / DECRYPTED ON-THE-FLY?
  before_create do
    self.api_key = loop do
      api_key = SecureRandom.base64.tr('+/=', 'Qrt')
      break api_key unless User.exists?(api_key: api_key)
    end
  end

  def generate_pin_code
    # MOVE THIS CHECKING LOGIC TO invite_code.rb
    # IT DOES NOT BELONG HERE
    if self.lab.invite_codes.count < 5
      self.invite_codes.create!({ lab: self.lab })
      # InviteCode.create!(
      #   lab: self.lab,
      #   user: self,
      # )
    else
      self.errors.add(:error, "Use your lab's existing pin codes")
      return false
    end
  end

  protected

    # Generate a unique API key
    # SHOULD THIS BE ENCRYPRED / DECRYPTED ON-THE-FLY?
   # def generate_api_key
   #   loop do
   #     api_key = SecureRandom.base64.tr('+/=', 'Qrt')
   #     break api_key unless User.exists?(api_key: api_key)
   #   end
   # end

end
