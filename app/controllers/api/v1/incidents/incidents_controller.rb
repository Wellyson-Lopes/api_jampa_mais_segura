module Api
  module V1
    module Incidents
      class IncidentsController < ApplicationUsersController
        skip_before_action :verify_authenticity_token
        before_action :authenticate_user!

        def index
          incidents = Incident.all
          render json: incidents, status: :ok
        end

        def list_of_crime_types
          crime_types = CrimeType.all
          render json: crime_types, status: :ok
        end

        def create
          incident = Incident.new(incident_params)
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
