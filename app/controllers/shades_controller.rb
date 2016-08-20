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
  end

  # GET /shades/new
  def new
    @shade = Shade.new
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
    #cannot update shades
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
      params.require(:shade).permit(:name, :finish, :product_id, :color_id, :hex_color)
    end
end
