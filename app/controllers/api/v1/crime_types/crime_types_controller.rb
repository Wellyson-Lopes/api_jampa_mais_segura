module Api
  module V1
    module CrimeTypes
      class CrimeTypesController < ApplicationUsersController
        skip_before_action :verify_authenticity_token
        before_action :authenticate_user!

        def create
          crime_type = CrimeType.new(crime_type_params)
          if crime_type.save
            render json: crime_type, status: :created
          else
            render json: { errors: crime_type.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        def crime_type_params
          params.require(:crime_type).permit(:name)
        end
      end
    end
  end
end
