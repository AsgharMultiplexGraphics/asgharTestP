class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :friends

  belongs_to :company, optional: true     
  
  after_create :assign_company

  def name
    "#{first_name} #{last_name}"
  end

  def assign_company
    if company.blank?  
      create_company(owner: self, name: "#{email} comany")
    end
  end
end
