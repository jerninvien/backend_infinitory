# == Schema Information
#
# Table name: users
#
#  id                 :bigint(8)        not null, primary key
#  admin              :boolean          default(FALSE), not null
#  api_key            :string
#  name               :string           not null
#  role               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  invited_by_user_id :integer
#  lab_id             :bigint(8)
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
  belongs_to :lab, inverse_of: :users
  has_many :invite_codes, inverse_of: :user, dependent: :destroy
  has_many :bookings
  has_many :devices, through: :bookings

  validates :name,
    presence: true,
    length: {
      in: 2..40,
      message: "Your name should be between 2 and 40 characters long"
    }

  def invited_by
    if self.invited_by_user_id
      User.find(self.invited_by_user_id)
    end
  end

  def generate_pin_code
    if self.lab.invite_codes.count < 5
      InviteCode.create!(
        lab: self.lab,
        user: self,
      )
    else
      puts "Please use your lab's existing pin codes"
      self.errors.add(:error, "Use your lab's existing pin codes")
      return false
    end
  end

  protected
    # Assign an API key on create
    before_create do
      self.api_key = generate_api_key
    end

    # Generate a unique API key
   def generate_api_key
     loop do
       api_key = SecureRandom.base64.tr('+/=', 'Qrt')
       break api_key unless User.exists?(api_key: api_key)
     end
   end

end
