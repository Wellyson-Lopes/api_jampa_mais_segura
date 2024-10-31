# == Schema Information
#
# Table name: crime_types
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class CrimeTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
