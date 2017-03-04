class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show]
  before_action :set_private_profile, only: [:new, :create, :update, :edit, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @home_page = "profile"
    @username = @profile.username
    @profile_owner = current_user && @username == current_user.username
    @my_looks = @profile.looks.order(created_at: :desc)
    @test = Profile.get_profile_picture("chileanqween")
    # @response = HTTParty.get('https://api.instagram.com/oembed?url=https://www.instagram.com/p/8mb17gSyyC/')
    # @looks = @profile.looks
  end

  # GET /profiles/new
  def new
    @profile = @account.build_profile
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = @account.build_profile(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def set_private_profile
      @profile = current_user.account.profile
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(
        :about,
        :avatar_url,
        :website_url,
        :instagram_url,
        :facebook_url,
        :twitter_url,
        :youtube_url
      )
    end
end
