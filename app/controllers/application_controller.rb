class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :store_current_location, :unless => :devise_controller?

  helper_method :user_administrator?, :short_product_type

  def short_product_type(product_type)
    query = ""
    products = ["eye", "lip", "brow", "face"]
    products.each do |prod|
      if product_type.downcase.include?(prod)
        return query = prod
      end
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end

    def user_administrator?
      user_signed_in? && current_user.username == "administrator"
    end

  private

    def store_current_location
      store_location_for(:user, request.url)
    end

    def set_cache_headers
      response.headers["Cache-Control"] = "no-cache, no-store"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end

    def after_sign_out_path_for(resource)
      request.referrer || root_path
    end

end
