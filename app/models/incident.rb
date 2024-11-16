# == Schema Information
#
# Table name: incidents
#
#  id                    :bigint           not null, primary key
#  address               :string
#  city                  :string           not null
#  date                  :date             not null
#  disabled              :boolean          default(FALSE)
#  district              :string
#  latitude              :decimal(10, 6)   not null
#  longitude             :decimal(10, 6)   not null
#  number_of_individuals :integer
#  observations          :text
#  target                :string
#  time                  :time
#  vehicle_description   :string
#  weapon_type           :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  crime_type_id         :bigint           not null
#  user_id               :bigint           not null
#
# Indexes
#
#  index_incidents_on_crime_type_id  (crime_type_id)
#  index_incidents_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (crime_type_id => crime_types.id)
#  fk_rails_...  (user_id => users.id)
#
class Incident < ApplicationRecord
  belongs_to :crime_type
  belongs_to :user

  validate :validate_city_and_district

  private

  def validate_city_and_district
    return if city == "João Pessoa" && district.present?

    errors.add(:base, "A ocorrência deve ser na cidade de João Pessoa e em um bairro válido.")
  end
end
