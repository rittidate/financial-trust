module Admin
  class AccountsController < BaseController
    def new
      @users = User.all
      @account = Account.new
    end

    def create
      @user = User.find(params[:account][:user_id])
      type = params[:account][:type]
      interest_rate = params[:account][:interest_rate] || 0.0
      
      # Security: Whitelist allowed types
      unless %w[SavingsAccount InvestingAccount].include?(type)
        redirect_to new_admin_account_path, alert: "Invalid account type"
        return
      end

      # Dynamically create the account type
      @account = type.constantize.new(user: @user, balance: 0, interest_rate: interest_rate)

      if @account.save
        redirect_to root_path, notice: "#{type} created successfully for #{@user.name}"
      else
        @users = User.all
        flash.now[:alert] = @account.errors.full_messages.to_sentence
        render :new, status: :unprocessable_entity
      end
    end
  end
end
