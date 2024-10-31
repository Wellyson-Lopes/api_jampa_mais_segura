class Incident < ApplicationRecord
  belongs_to :crime_type
  belongs_to :user
end
