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
      message: 'Your name should be between 2 and 40 characters long'
    }

  # Assign an API key on create
  before_create do |user|
    user.api_key = user.generate_api_key
  end


  # Generate a unique API key
 def generate_api_key
   loop do
     token = SecureRandom.base64.tr('+/=', 'Qrt')
     break token unless User.exists?(api_key: token)
   end
 end

end
