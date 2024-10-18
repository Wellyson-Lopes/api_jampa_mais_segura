module Admins
  class SessionsController < Devise::SessionsController
    def create
      super do |resource|
      end
    end

    def new
      super
    end

    def destroy
      super
    end
  end
end
