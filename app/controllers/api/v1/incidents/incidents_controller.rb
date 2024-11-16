module Api
  module V1
    module Incidents
      class IncidentsController < ApplicationUsersController
        skip_before_action :verify_authenticity_token
        before_action :authenticate_user!

        def index
          incidents = Incident.find_by(user_id: @current_user.id)
          render json: incidents, status: :ok
        end

        def list_of_crime_types
          crime_types = CrimeType.all
          render json: crime_types, status: :ok
        end

        def create
          response_address = Search::GeolocationAddress.new(latitude: params[:latitude], longitude: params[:longitude]).call

          render json: { errors: "Erro ao buscar endereço: #{response_address[:error]}" }, status: :unprocessable_entity unless response_address[:error].nil?

          incident = Incident.new(incident_params)
          incident.address = response_address[:address]
          incident.district = response_address[:district]
          incident.city = response_address[:city]

          if incident.save
            render json: incident, status: :created
          else
            render json: { errors: incident.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        def incident_params
          params.require(:incident).permit(
            :crime_type_id, :latitude, :longitude, :city, :address, :district, :date,
            :time, :disabled, :observations, :vehicle_description, :weapon_type,
            :number_of_individuals, :target, :user_id
          )
        end
      end
    end
  end
end
