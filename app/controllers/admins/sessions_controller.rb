module Admins
  class SessionsController < Devise::SessionsController
    def create
      super do |resource|
      end
    end
  end
end
