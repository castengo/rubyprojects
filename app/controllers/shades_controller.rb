class ShadesController < ApplicationController
  before_action :set_product
  before_action :set_shade, only: [:show, :destroy]

  # GET /shades
  # GET /shades.json
  def index
    @shades = Shade.all
  end

  # GET /shades/1
  # GET /shades/1.json
  def show
    spot_on_colors = Color.close_colors(@shade.color,10,5,2).pluck(:id)
    @spot_on_shades = Shade.where.not(:product_id => @shade.product).where(:color_id => spot_on_colors)
    @close_call_colors = Color.close_colors(@shade.color,30,20,10).where.not(:id => spot_on_colors).limit(12)
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
    @shade = @product.shades.new(shade_params)
    @color = Color.find_by(:hex => shade_params[:hex_color])
    if @color.nil?
      @color = Color.new(:hex => shade_params[:hex_color])
    end
    # could use find_or_create_by(:hex => shade_params[:hex_color])
    @color.shades << @shade
    if @color.save && @shade.save
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
    @color = Color.find(@shade.color_id)
    if @color.shades.count == 0
      @color.destroy
    end
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
      params.require(:shade).permit(:name, :finish, :product_id, :color_id, :hex_color, :position)
    end
end
