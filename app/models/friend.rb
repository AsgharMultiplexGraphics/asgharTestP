class Friend < ApplicationRecord
    belongs_to :user


    def owner(current_user)
        self.user == current_user
      end
    
end
