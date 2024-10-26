module Admins
  class RegistrationsController < Devise::SessionsController
    def new
      @admin = Admin.new
    end

    def create
      @admin = Admin.new(admin_params)
      if @admin.save
        sign_in(@admin)
        redirect_to root_path, notice: "Admin created successfully."
      else
        render :new
      end
    end

    def edit
      @admin = current_admin
    end

    def update
      @admin = current_admin
      if @admin.update(admin_params)
        sign_in(@admin)
        redirect_to root_path, notice: "Admin updated successfully."
      else
        render :edit
      end
    end

    private

    def admin_params
      params.require(:admin).permit(:name, :cpf, :phone, :email, :password, :admin, :public_servant, :password_confirmation)
    end
  end
end
