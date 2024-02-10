class MembersController < ApplicationController
  def index
    company=current_user.company
    @users = company.users
  end

  def create
    company = current_user.company 
   if user=  company.users.create(member_params)
    redirect_to member_path(user)
   end
  end

  def new
    @member=User.new

  end

  def edit
    @member = current_user.company.members.find(params[:id])
  end

  def update
    @member = current_user.company.members.find(params[:id])
    if @member.update(member_params)
      redirect_to member_path(@member)
    end
  end
  def show
    @member = current_user.company.members.find(params[:id])
  end
  def destroy
  end

  protected 
  def member_params
    params.require(:user).permit :email, :password, :first_name, :last_name, :age, :gender
  end 
end
