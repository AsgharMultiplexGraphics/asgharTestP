class Company < ApplicationRecord
    has_one :owner, class_name: 'User'

    has_many :users
    has_many :members, class_name: 'User'
end
