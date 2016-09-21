class ProductsController < ApplicationController
  before_action :set_brand, only: [:new, :create]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    if params[:name]
      @products = Product.search(params[:name])
    else
      @products = Product.all.order(:views)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @brand = Brand.find(@product.brand)
    @shades = @product.shades.order(:position)
    # @matching_products = @product.find_matching_products
    if user_signed_in? && current_user.username == "administrator"
      @product.views = @product.views.nil? ? 1 : @product.views + 1
      @product.save
    end
  end

  # GET /products/new
  def new
    @product = @brand.products.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = @brand.products.new(product_params)
    if @product.save
      redirect_to @brand, notice: 'Product was successfully created.'
    else
      redirect_to @brand, alert: 'Unable to add product.'
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def set_brand
      @brand = Brand.find(params[:brand_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :photo_url, :price, :brand_id, :direct_link, :application, :no_of_shades, :product_type, :shades_group, :multiple_colors, shades_attributes: [:id, :name, :finish, :product_id, :color_id, :hex_color, :position, :_destroy, :h, :s, :l, :colors_array])
    end
end
