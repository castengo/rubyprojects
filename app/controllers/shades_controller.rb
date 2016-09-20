class ShadesController < ApplicationController
  before_action :set_product, only: [:show, :create, :update, :destroy]
  before_action :set_shade, only: [:show, :destroy]
  # GET /shades
  # GET /shades.json
  def index
    if params[:search]
      @shades = Shade.search(params[:search]).order(:h, :s, :l)
    else
      @shades = Shade.all.order(:h, :s, :l)
    end

    respond_to do |format|
      format.html
      format.js
    end

  end

  # GET /shades/1
  # GET /shades/1.json
  def show
    @short_product_type = short_product_type(@shade.product.product_type)
    # matching color and product type
    @spot_on_shades = @shade.close_colors(10,5,2).joins(:product).where("lower(product_type) LIKE '%#{@short_product_type}%'").order("ABS('#{@shade.h}' - h)")
    # matching color but not product_type
    @close_call_colors = @shade.close_colors(10,5,2).joins(:product).where.not("lower(product_type) LIKE '%#{short_product_type(@shade.product.product_type)}%'").order("ABS('#{@shade.h}' - h)")

    # don't show product if coming from product page
    @controller = Rails.application.routes.recognize_path(request.referrer)[:controller]
    if @controller == "products"
      @spot_on_shades = @spot_on_shades.where.not(:product_id => @shade.product).order("ABS('#{@shade.h}' - h)")
      @close_call_colors = @close_call_colors.where.not(:product_id => @shade.product).order("ABS('#{@shade.h}' - h)")
    end
  end

  # GET /shades/new
  def new
  end

  # GET /shades/1/edit
  def edit
    #cannot edit shades
  end

  # POST /shades
  # POST /shades.json
  def create
    @shade = @product.shades.build(shade_params)
    if @shade.save
      redirect_to @product, notice: 'Shade was successfully created.'
    else
      redirect_to @product, alert: "Shade couldn't be created."
    end
  end

  # PATCH/PUT /shades/1
  # PATCH/PUT /shades/1.json
  def update
  end

  # DELETE /shades/1
  # DELETE /shades/1.json
  def destroy
    @shade.destroy
    redirect_to @product, notice: 'Shade was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shade
      @shade = @product.shades.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shade_params
      params.require(:shade).permit(:name, :finish, :product_id, :color_id, :hex_color, :position, :h, :s, :l, :colors_array)
    end

end
