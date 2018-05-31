# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  invited_by :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lab_id     :bigint(8)
#
# Indexes
#
#  index_users_on_lab_id  (lab_id)
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