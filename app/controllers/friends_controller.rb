class FriendsController < ApplicationController
  before_action :set_friend, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :correct_user_or_admin, only: [:edit, :update, :destroy]
  # before_action :set_friend, only: %i[ show edit update destroy ]
  # before_action :authenticate_user!, except: [:index, :show]
  # before_action :correct_user, only: [:edit, :update, :destroy]
  # GET /friends or /friends.json
  def index
    @admins = User.where(role: 'admin')
    @cashiers = User.where(role: 'cashier')
    @managers = User.where(role: 'manager')
  @cashier_f = @cashiers.sum { |cashier| cashier.friends.size }
  @manager_f = @managers.sum { |manager| manager.friends.size }
  @admin_f = @admins.sum { |admin| admin.friends.size }

  @total_f =  @cashier_f + @admin_f + @manager_f
    @friends = Friend.all 
  end

  # GET /friends/1 or /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    # @friend = Friend.new
    @friend = current_user.friends.build
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends or /friends.json
  def create
    # @friend = Friend.new(friend_params)
    @friend = current_user.friends.build(friend_params)
    respond_to do |format|
      if @friend.save
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    if @friend.destroy
      flash[:notice] = "Friend was successfully deleted."
    else
      flash[:alert] = "An error occurred while deleting the friend."
    end
    redirect_to friends_url
  end
  # def destroy
  #   unless @friend.owner(current_user)
  #     flash[:alert] = "You are not authorized to delete this friend."
  #     redirect_to friends_path
  #     return
  #   end

  #   begin
  #     @friend.destroy!
  #     flash[:notice] = "Friend was successfully deleted."
  #   rescue StandardError => e
  #     flash[:alert] = "An error occurred: #{e.message}"
  #   end

  #   respond_to do |format|
  #     format.html { redirect_to friends_url }
  #     format.json { head :no_content }
  #   end
  # end

  # def destroy
  #   # @friend = Friend.find(params[:id])
  #   # @friend.destroy!

  #   unless @friend.owner? 
  #   begin
  #     @friend.destroy!
  #     flash[:notice] = "Friend was successfully deleted."
  #   rescue StandardError => e
  #     flash[:alert] = "An error occurred: #{e.message}"
  #   end
  # end

    # respond_to do |format|
    #   format.html { redirect_to friends_url, notice: "Friend was successfully deleted." }
    #   format.json { head :no_content }
  #   respond_to do |format|
  #     format.html { redirect_to friends_url }
  #     format.json { head :no_content }
  #   end
  # end
  # def correct_user 
  #   @friend = current_user.friends.find_by(id: params[:id])
  #   redirect_to friends_path, notice: "Not Authorized To Edit" if @friend.nil?
    
  # end
  private
  def correct_user_or_admin
    @friend = Friend.find(params[:id])
    unless @friend.user == current_user || current_user.admin?
      redirect_to friends_path, notice: "Not authorized to edit this friend."
    end
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :phone, :twitter, :user_id)
    end
end
