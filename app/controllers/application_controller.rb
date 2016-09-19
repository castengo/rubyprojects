class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user, :ensure_login, :short_product_type

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

    def ensure_login
      redirect_to login_path unless session[:user_id]
    end

  	def logged_in?
  		session[:user_id]
  	end

  	def current_user
  		@current_user ||= User.find(session[:user_id])
  	end
end
