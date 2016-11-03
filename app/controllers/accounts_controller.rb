class AccountsController < ApplicationController
  before_action :authenticate_user!

  def show
    @account = current_user.account
    if user_administrator?
      @users = User.all
    end
  end

end
