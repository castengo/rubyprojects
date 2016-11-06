class LooksController < ApplicationController
  before_action :set_look, only: [:edit, :show, :update, :add_shade, :destroy]
  before_action :set_profile, only: [:new, :create]
  respond_to :html, :js

  # GET /looks
  # GET /looks.json
  def index
    @home_page = "looks"
    @looks = Look.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 3)
  end

  # GET /looks/1
  # GET /looks/1.json
  def show
    @products = Product.where(:id => @look.shades.pluck(:product_id).uniq)
  end


  # GET /looks/new
  def new
    @look = @profile.looks.new
  end

  # GET /looks/1/edit
  def edit
  end

  # POST /looks
  # POST /looks.json
  def create
    @look = @profile.looks.new(look_params)
    respond_to do |format|
      if @look.save
        format.html { redirect_to @profile, notice: 'Look was successfully created.' }
        # format.json { render :show, status: :created, location: @look }
      else
        format.html { render :new }
        format.json { render json: @look.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /looks/1
  # PATCH/PUT /looks/1.json
  def update
    respond_to do |format|
      if @look.update(look_params)
        format.html { redirect_to @look.profile, notice: 'Look was successfully updated.' }
        format.json { render :show, status: :ok, location: @look.profile }
      else
        format.html { render :edit }
        format.json { render json: @look.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /looks/1
  # DELETE /looks/1.json
  def destroy
    @profile = @look.profile
    @look.destroy
    respond_to do |format|
      format.html { redirect_to @profile, notice: 'Look was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_look
      @look = Look.find(params[:id])
    end

    def set_profile
      @profile = Profile.find(params[:profile_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def look_params
      params.require(:look).permit(:name, :caption, :image_url, :tags)
    end
end
