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

require 'test_helper'

class LabTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
