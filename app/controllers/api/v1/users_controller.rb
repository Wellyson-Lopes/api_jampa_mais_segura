module Api
  module V1
    class UsersController < ApplicationUsersController
      protect_from_forgery with: :null_session
      before_action :authenticate_user!, only: [:update, :logout, :destroy]

      def login
        normalized_cpf = normalize_cpf(params[:cpf])
        user = User.find_for_database_authentication(cpf: normalized_cpf)
        if user&.valid_password?(params[:password])
          token = generate_jwt(user)
          render json: { token: token, user: user }, status: :ok
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end

      def logout
        head :no_content
      end

      def create
        user = User.new(user_params)

        if user.save
          render json: { message: 'Usuário criado com sucesso!', user: user }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        user = current_user
        if user.nil?
          render json: { error: 'User not authenticated' }, status: :unauthorized
          return
        end

        if user.update(user_params)
          render json: { message: 'Usuário atualizado com sucesso!', user: user }, status: :ok
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        user = current_user
        if user.destroy
          render json: { message: 'Conta deletada com sucesso' }, status: :ok
        else
          render json: { error: 'Não foi possível deletar a conta' }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:cpf, :phone, :password, :password_confirmation)
      end

      def generate_jwt(user)
        JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, ENV['JWT_SECRET_KEY'])
      end

      def normalize_cpf(cpf)
        cpf.gsub(/\D/, '') if cpf.present?
      end
    end
  end
end
