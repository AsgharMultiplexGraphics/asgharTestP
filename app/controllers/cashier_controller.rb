class CashierController < ApplicationController
    def index
        @main_categories = Category.take(100)
        
    end
end