class HomeController < ApplicationController
  def index
  end
  def about
    @about_me = "Hi! My Name is Asghar Ali"
  end
end
