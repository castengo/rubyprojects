class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :short_product_type

  def after_sign_in_path_for(resource)
    root_path
  end

  def short_product_type(product_type)
    query = ""
    products = ["eye", "lip"]
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

end
