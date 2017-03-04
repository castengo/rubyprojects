class ShadesController < ApplicationController
  before_action :set_product, only: [:show, :create, :update, :destroy]
  before_action :set_shade, only: [:show, :destroy]
  before_action :set_shades, only: [:index, :paginate, :search]
  before_filter :set_cache_headers
  respond_to :html, :js

  # GET /shades
  # GET /shades.json
  def index
    @shades = @shades.limit(@results_limit)
    @page = 1
    @more_shades = @shades_count > @results_limit
  end

  def paginate
    offset = params[:page].to_i * @results_limit
    @page = params[:page].to_i + 1
    @shades = @shades.limit(@results_limit).offset(offset)
    # test if there's more shades
    @more_shades = @page * @results_limit < @shades_count
  end

  def search
    @shades = @shades.limit(@results_limit)
    @page = 1
    @empty_shades = @shades.empty?
    @more_shades = @shades_count > @results_limit
  end

  # GET /shades/1
  # GET /shades/1.json
  def show
    # matching color and product type
    @spot_on_shades = @shade.close_colors(10,5,2).where("lower(short_type) LIKE ?", @shade.product.short_type).order("ABS('#{@shade.h}' - h)")
    # matching color but not product_type
    @close_call_colors = @shade.close_colors(10,5,2).where.not("lower(short_type) LIKE ?", @shade.product.short_type).order("ABS('#{@shade.h}' - h)")

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

    def set_shades
      if !params[:search].nil?
        @shades = Shade.search(params[:search]).order(:h, :s, :l)
      else
        @shades = Shade.all.order(:h, :s, :l)
      end
      @results_limit = 18
      @shades_count = @shades.count
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_shade
      @shade = @product.shades.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shade_params
      params.require(:shade).permit(
        :name,
        :finish,
        :product_id,
        :color_id,
        :hex_color,
        :position,
        :h,
        :s,
        :l,
        :colors_array
      )
    end

end
