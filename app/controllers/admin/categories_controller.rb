class Admin::CategoriesController < ApplicationController
  before_action :set_admin_category, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :correct_user_or_admin, only: [:edit, :update, :destroy]

  # GET /admin/categories or /admin/categories.json
  def index
    @admins = User.where(role: 'admin')
    @cashiers = User.where(role: 'cashier')
    @managers = User.where(role: 'manager')
  @cashier_c = @cashiers.sum { |cashier| cashier.categories.size }
  @manager_c = @managers.sum { |manager| manager.categories.size }
  @admin_c = @admins.sum { |admin| admin.categories.size }

  @total_c =  @cashier_c + @admin_c + @manager_c
  @admin_categories = Category.all
 
  end

  # GET /admin/categories/1 or /admin/categories/1.json
  def show
    #@admin_category = Category.find(params[:id])
  end

  # GET /admin/categories/new
  def new
    # @admin_category = Category.new
    @admin_category = current_user.categories.build
  end

  # GET /admin/categories/1/edit
  def edit
   
  end

  # POST /admin/categories or /admin/categories.json
  def create
    # @admin_category = Category.new(admin_category_params)

    # respond_to do |format|
    #   if @admin_category.save
    #     format.html { redirect_to admin_category_url(@admin_category), notice: "Category was successfully created." }
    #     format.json { render :show, status: :created, location: @admin_category }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @admin_category.errors, status: :unprocessable_entity }
    #   end
    # end

# @friend = Friend.new(friend_params)
@admin_category = current_user.categories.build(admin_category_params)
  respond_to do |format|
      if @admin_category.save
        format.html { redirect_to admin_category_url(@admin_category), notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @admin_category }
        else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_category.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /admin/categories/1 or /admin/categories/1.json
  def update
    respond_to do |format|
      if @admin_category.update(admin_category_params)
        format.html { redirect_to admin_category_url(@admin_category), notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/categories/1 or /admin/categories/1.json
  def destroy
    # @admin_category.destroy!

    # respond_to do |format|
    #   format.html { redirect_to admin_categories_url, notice: "Category was successfully destroyed." }
    #   format.json { head :no_content }
    # end

    if @admin_category.destroy

      flash[:notice] = "Category was successfully deleted."
    else
      flash[:alert] = "An error occurred while deleting the friend."
    end
    redirect_to admin_categories_url

  end

  private

  def correct_user_or_admin
    @admin_category = Category.find(params[:id])
    unless @admin_category.user == current_user || current_user.admin?
      redirect_to admin_categories_path, notice: "Not authorized to edit this friend."
    end
  end
   
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_category
      @admin_category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_category_params
      params.require(:category).permit(:name, :description)
    end
end
