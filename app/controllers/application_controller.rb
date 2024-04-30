class ApplicationController < ActionController::Base
  # before_action :set_root_path_for_admin
  # before_action :require_admin
  
    protected
    
  
    # def after_sign_up_path_for(resource)
    #    edit_members_path
    # end
    def after_sign_in_path_for(resource)
      home_index_path
    end
    
    def require_admin
      if !current_user&.admin?
            redirect_to home_index_path, notice: "you dont have access for this action."
      end
    end
    # private

  # def set_root_path_for_admin
  #   redirect_to admin_path if current_user&.admin?
  # end
end
