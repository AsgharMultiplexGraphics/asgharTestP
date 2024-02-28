class ApplicationController < ActionController::Base

    protected

    def require_admin
      if !current_user&.admin?
            redirect_to root_path, notice: "you dont have access for this action."
      end
    end
end
