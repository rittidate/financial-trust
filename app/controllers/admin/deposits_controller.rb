module Admin
  class DepositsController < BaseController
    def index
      @deposits = Deposit.where(status: "pending").order(created_at: :desc)
    end

    def approve
      @deposit = Deposit.find(params[:id])
      
      ActiveRecord::Base.transaction do
        @deposit.update!(status: "approved")
        
        # Credit the account
        account = @deposit.account
        account.with_lock do
          account.balance += @deposit.amount
          account.save!
          
          LedgerEntry.create!(
            account: account,
            amount: @deposit.amount,
            entry_type: "transfer_in" # Utilizing existing type for deposit
          )
        end
      end

      redirect_to admin_deposits_path, notice: "Deposit approved and account credited."
    rescue ActiveRecord::RecordInvalid
      redirect_to admin_deposits_path, alert: "Failed to approve deposit."
    end

    def reject
      @deposit = Deposit.find(params[:id])
      @deposit.update(status: "rejected")
      redirect_to admin_deposits_path, notice: "Deposit rejected."
    end
  end
end
