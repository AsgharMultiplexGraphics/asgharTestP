class ApplicationController < ActionController::Base

    protected
    def after_sign_in_path_for(resource)
      home_index_path
    end
  
    def after_sign_up_path_for(resource)
      members_profile_path
    end

    def require_admin
      if !current_user&.admin?
            redirect_to home_index_path, notice: "you dont have access for this action."
      end
    end
end
