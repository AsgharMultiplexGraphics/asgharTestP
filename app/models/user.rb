class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friends

  belongs_to :company, optional: true     
  
  after_create :after_create_hooks

  
  
  # enum gender: {
  #   Male: 1,
  #   Female:2 
  # }
  enum role: {
    admin: 1,
    member: 2 
  }
  def owner(current_user)
    self== current_user
  end
  def name
    "#{first_name} #{last_name}"
  end

  def after_create_hooks
    if company.blank?  
      admin!
      create_company(owner: self, name: "#{email} comany")
    end
  end
end
