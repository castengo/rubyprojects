class StaticPagesController < ApplicationController
  def home
    # render :layout => "home_page"
    @page = "Home"
  end

  def about
  end

  def help
  end
end
