class Admin::ProductsController < ApplicationController
  before_action :set_admin_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :correct_user_or_admin, only: [:edit, :update, :destroy]



  # GET /admin/products or /admin/products.json
  def index
    @admins = User.where(role: 'admin')
    @cashiers = User.where(role: 'cashier')
    @managers = User.where(role: 'manager')
  @cashier_p = @cashiers.sum { |cashier| cashier.products.size }
  @manager_p = @managers.sum { |manager| manager.products.size }
  @admin_p = @admins.sum { |admin| admin.products.size }

  @total_p =  @cashier_p + @admin_p + @manager_p
    @admin_products = Product.all
  end

  # GET /admin/products/1 or /admin/products/1.json
  def show
  end

  # GET /admin/products/new
  def new
    @admin_product = current_user.products.build
  end

  # GET /admin/products/1/edit
  def edit
  end

  # POST /admin/products or /admin/products.json
  def create
    # @admin_product = Product.new(admin_product_params)    
    @admin_product = current_user.products.build(admin_product_params)
    respond_to do |format|
        if @admin_product.save
          format.html { redirect_to admin_product_url(@admin_product), notice: "Product was successfully created." }
          format.json { render :show, status: :created, location: @admin_product }
          else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @admin_product.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /admin/products/1 or /admin/products/1.json
  def update
    @admin_product = Product.find(params[:id])
    if @admin_product.update(admin_product_params.reject { |k| k["images"] })
      if admin_product_params["images"]
        admin_product_params["images"].each do |image|
          @admin_product.images.attach(image)
        end
      end
      redirect_to admin_products_path, notice: "Product updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/products/1 or /admin/products/1.json
  def destroy
    # @admin_product.destroy!

    # respond_to do |format|
    #   format.html { redirect_to admin_products_url, notice: "Product was successfully destroyed." }
    #   format.json { head :no_content }
    # end

    if @admin_product.destroy

      flash[:notice] = "Category was successfully deleted."
    else
      flash[:alert] = "An error occurred while deleting the friend."
    end
    redirect_to admin_products_url




  end

  private

  def correct_user_or_admin
    @admin_product = Product.find(params[:id])
    unless  @admin_product.user == current_user || current_user.admin?
      redirect_to admin_products_path, notice: "Not authorized to edit this friend."
    end
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_product
      @admin_product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_product_params
      params.require(:product).permit(:name, :description, :price, :category_id, :user_id, :active, images: [])
    end
end
