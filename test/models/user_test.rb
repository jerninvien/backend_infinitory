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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
