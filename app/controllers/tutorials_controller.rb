class TutorialsController < ApplicationController
  # before_action :set_look
  # after_action :set_shades
  respond_to :html, :js

  def create
    @look = Look.find(params[:look_id])
    @look.tutorials.create(shade_id: params[:shade_id])
    if params[:search]
      @found_shades = Shade.search(params[:search]).where.not(:id => @look.shades).order(:name)
    end
    @shades = @look.shades
  end

  def destroy
    @look = Look.find(params[:id])
    @look.tutorials.find_by(shade_id: params[:shade_id]).destroy
    if params[:search]
      @found_shades = Shade.search(params[:search]).where.not(:id => @look.shades).order(:name)
    end
    @shades = @look.shades
  end

  private

    def set_look
      @look = Look.find(params[:look_id])
    end

    def set_shades
      if params[:search]
        @found_shades = Shade.search(params[:search]).where.not(:id => @look.shades).order(:name)
      end
      @shades = @look.shades
    end

end
