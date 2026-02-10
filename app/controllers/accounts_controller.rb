class AccountsController < ApplicationController
  before_action :set_account, only: [:update]

  def update
    if @account.update(account_params)
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Account updated successfully." }
        format.turbo_stream
      end
    else
      redirect_to root_path, alert: "Failed to update account."
    end
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name)
  end
end
