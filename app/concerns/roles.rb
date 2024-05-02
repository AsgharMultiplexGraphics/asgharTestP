# app/concerns/roles.rb

module Roles
    extend ActiveSupport::Concern
  
    PERMISSIONS = {
      admin: [:all],
      manager: [:products, :inventory],
      cashier: [:cart, :checkout]
    }
  
    def has_permission?(action)
      PERMISSIONS[current_user.role].include?(action)
    end
  
    def authorize(action)
      raise CanCan::AccessDenied unless has_permission?(action)
    end
  end
  