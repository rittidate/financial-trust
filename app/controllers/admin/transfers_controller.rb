module Admin
  class TransfersController < BaseController
    def new
      @accounts = Account.includes(:user).all.group_by(&:user)
    end

    def create
      @source = Account.find(params[:source_id])
      @target = Account.find(params[:target_id])
      @amount = params[:amount].to_d

      if InternalTransferService.new(@source, @target, @amount).call
        redirect_to admin_accounts_path, notice: "Transfer successful."
      else
        redirect_to new_admin_transfer_path, alert: "Transfer failed."
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to new_admin_transfer_path, alert: "Account not found."
    end
  end
end
