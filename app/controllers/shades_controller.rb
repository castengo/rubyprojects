class ShadesController < ApplicationController
  before_action :set_product, only: [:show, :create, :update, :destroy]
  before_action :set_shade, only: [:show, :destroy]
  helper
  # GET /shades
  # GET /shades.json
  def index
    @shades = Shade.all.order(:l, :s, :h)
  end

  # GET /shades/1
  # GET /shades/1.json
  def show
    @spot_on_shades = @shade.close_colors(10,5,2).where.not(:product_id => @shade.product).order("ABS('#{@shade.h}' - h)")
    @close_call_colors = @shade.close_colors(20,10,4).where.not(:id => @spot_on_shades, :product_id => @shade.product).limit(12).order("ABS('#{@shade.h}' - h)")
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
      params.require(:shade).permit(:name, :finish, :product_id, :color_id, :hex_color, :position, :h, :s, :l)
    end

end
