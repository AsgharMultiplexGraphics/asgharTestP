class Category < ApplicationRecord
    has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [50, 50]
  end
    belongs_to :user


    def owner(current_user)
        self.user == current_user
      end
end
