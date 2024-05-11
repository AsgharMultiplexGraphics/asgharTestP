class HomeController < ApplicationController

  def index
    # @main_categories = Category.take(4)
  
  end

  def about
    @about_me = "Hi! My Name is Asghar Ali"


    if params[:first_number].present? && params[:second_number].present?
      @first_number = params[:first_number].to_i
      @second_number = params[:second_number].to_i
      @result = @first_number + @second_number
    end
  end
end
