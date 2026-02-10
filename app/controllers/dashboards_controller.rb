class DashboardsController < ApplicationController
  def show
    @user = current_user
    @savings = @user.savings_account
    @investing = @user.investing_account
  end
end
