class DepositsController < ApplicationController
  def new
    @deposit = Deposit.new
  end

  def create
    @deposit = Deposit.new(deposit_params.except(:account_type))
    @deposit.account = current_user.accounts.find_by(type: deposit_params[:account_type])

    if @deposit.account && @deposit.save
      redirect_to root_path, notice: "Deposit request submitted successfully. Pending approval."
    else
      @deposit.errors.add(:base, "Account not found") unless @deposit.account
      render :new, status: :unprocessable_entity
    end
  end

  private

  def deposit_params
    params.require(:deposit).permit(:amount, :slip, :account_type)
  end
end
