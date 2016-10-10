class AccountsController < ApplicationController
  def show
    @users = User.all
    @account = current_user.account
  end
end
