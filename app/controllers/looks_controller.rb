class LooksController < ApplicationController
  before_action :set_look, only: [:show, :edit, :update, :destroy]

  # GET /looks
  # GET /looks.json
  def index
    @looks = Look.all
  end

  # GET /looks/1
  # GET /looks/1.json
  def show
  end

  # GET /looks/new
  def new
    @look = Look.new
  end

  # GET /looks/1/edit
  def edit
  end

  # POST /looks
  # POST /looks.json
  def create
    @look = Look.new(look_params)

    respond_to do |format|
      if @look.save
        format.html { redirect_to @look, notice: 'Look was successfully created.' }
        format.json { render :show, status: :created, location: @look }
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
        format.html { redirect_to @look, notice: 'Look was successfully updated.' }
        format.json { render :show, status: :ok, location: @look }
      else
        format.html { render :edit }
        format.json { render json: @look.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /looks/1
  # DELETE /looks/1.json
  def destroy
    @look.destroy
    respond_to do |format|
      format.html { redirect_to looks_url, notice: 'Look was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_look
      @look = Look.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def look_params
      params.require(:look).permit(:name, :image_url, :tags, :artist)
    end
end
