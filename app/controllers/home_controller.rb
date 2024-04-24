class HomeController < ApplicationController
  def index
   # This method is used to add two numbers
    # def sum(first, second)
    # first.to_i + second.to_i
    # end

  # Check if form is submitted with numbers
    # if params[:first_number].present? && params[:second_number].present?
    # @first_number = params[:first_number].to_i
    # @second_number = params[:second_number].to_i
    # @result = sum(@first_number, @second_number)
    # end  
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
