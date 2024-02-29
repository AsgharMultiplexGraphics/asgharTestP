class MembersController < ApplicationController
  before_action :require_admin 

  def index
    @members = User.where(role: 'member')
  @admins = User.where(role: 'admin')
  @total_users = @members.size + @admins.size
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
  def profile
    @member = current_user.company.members.find(params[:id])
    if @member.profile(member_params)
      redirect_to member_path(@member)
    end
  end
  def edit
    if current_user.email == "asghar@gmail.com"
      @member = User.find(params[:id])
    else
      @member = current_user.company.members.find(params[:id])
    end
  end
  # def edit
  #   @member = current_user.company.members.find(params[:id])
  # end

  def update
    if current_user.email == "asghar@gmail.com"
      @member = User.find(params[:id])
    else
      @member = current_user.company.members.find(params[:id])
    end
    # @member = current_user.company.members.find(params[:id])
    if @member.update(member_params)
      redirect_to member_path(@member)
    end
  end

  def show
    if current_user.email == "asghar@gmail.com"
      @member = User.find(params[:id])
    else
      @member = current_user.company.members.find(params[:id])
    end
    # @member = current_user.company.members.find(params[:id])
  end

  def destroy
    @member = User.find(params[:id])
    if current_user.role == 'admin'
      if @member.destroy
        redirect_to members_path, notice: "User deleted Successfully."
      else
        redirect_to members_path, notice: "Failed to delete user."
      end
    else
      redirect_to members_path, notice: "You are not authorized to delete this user."
    end
  end
    
  # def destroy
  #   @member = User.find(params[:id])
  #   unless @member.owner(current_user)
  #     if @member.destroy
  #      redirect_to members_path
  #     end
  # end
  # end

  protected 
  def member_params
    params.require(:user).permit :role, :email, :password, :first_name, :last_name, :age, :gender
  end 
end
