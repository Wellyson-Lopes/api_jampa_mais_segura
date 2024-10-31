# == Schema Information
#
# Table name: crime_types
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CrimeType < ApplicationRecord
  has_many :incidents
end
