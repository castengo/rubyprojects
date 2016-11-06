class TutorialsController < ApplicationController
  respond_to :html, :js

  def create
    @look = Look.find(params[:look_id])
    @look.tutorials.create(shade_id: params[:shade_id])
    if params[:search]
      @found_shades = Shade.search(params[:search]).where.not(:id => @look.shades).order(:name)
    end
    @shades = @look.shades
  end

  def show
    @look = Look.find(params[:id])
    if current_user && current_user.username == @look.profile.username
      if params[:search]
        @found_shades = Shade.search(params[:search]).where.not(:id => @look.shades).order(:name)
      end
      @shades = @look.shades
    else
      redirect_to profile_path(@look.profile)
    end
  end

  def destroy
    @look = Look.find(params[:id])
    @look.tutorials.find_by(shade_id: params[:shade_id]).destroy
    if params[:search]
      @found_shades = Shade.search(params[:search]).where.not(:id => @look.shades).order(:name)
    end
    @shades = @look.shades
  end

end
