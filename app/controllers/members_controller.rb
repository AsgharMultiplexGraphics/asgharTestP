class MembersController < ApplicationController
  before_action :require_admin 

  def index
    company=current_user.company
    @users = company.users
  end

  def create
    company = current_user.company 
    user= company.users.create(member_params)

    if user.persisted?
      user.member! if user.role.blank?
      redirect_to member_path(user)
    else
      @member = user
      flash[:notice] = "please fix the validation errors"
      render :new
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
    @member = User.find(params[:id])
    unless @member.owner?
      if @member.destroy
       redirect_to members_path
      end
  end
  end

  protected 
  def member_params
    params.require(:user).permit :role, :email, :password, :first_name, :last_name, :age, :gender
  end 
end
