module Api
  module V1
    class ApplicationUsersController < ApplicationController
      include Devise::Controllers::Helpers

      def authenticate_user!
        token = request.headers['Authorization']&.split(' ')&.last
        if token
          begin
            secret = ENV['JWT_SECRET_KEY']
            decoded_token = JWT.decode(token, secret, true, { algorithm: 'HS256' }).first
            @current_user = User.find(decoded_token['user_id'])
          rescue JWT::DecodeError
            render json: { error: 'Invalid token' }, status: :unauthorized
          rescue ActiveRecord::RecordNotFound
            render json: { error: 'User not found' }, status: :unauthorized
          end
        else
          render json: { error: 'Token not provided' }, status: :unauthorized
        end
      end

      attr_reader :current_user
    end
  end
end
