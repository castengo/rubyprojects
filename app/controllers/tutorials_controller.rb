class TutorialsController < ApplicationController
  before_action :set_look, only: [:new, :show, :create, :destroy]
  before_action :set_shade, only: [:new, :destroy]
  before_action :profile_owner
  respond_to :html, :js

  def show
    if params[:search]
      @found_shades = Shade.search(params[:search]).where.not(:id => @look.shades).order(:name)
    end
    @shades = @look.shades
  end

  def new
    if @shade
      @look.shades.push(@shade)
      @look.save
    end
    @shades = @look.shades
    @remaining_shades = Shade.search(params[:search]).where.not(:id => @shades).order(:name)
  end

  # def create
  #   if @look.save
  #     redirect_to profile_path(@look.profile)
  #   else
  #   end
  # end

  def destroy
    @look.shades.destroy(@shade)
    @shades = @look.shades
  end

  private

    def set_look
      @look = Look.find(params[:look_id])
    end

    def set_shade
      @shade = Shade.find(params[:shade_id])
    end

    def profile_owner
      @profile_owner = @look.profile.account.user == current_user
      if !@profile_owner
        redirect_to root_path
      end
      @home_page ="look-shades"
    end
end
