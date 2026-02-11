class InterestCalculationService
  def call
    Account.transaction do
      Account.where("interest_rate > 0").find_each do |account|
        calculate_interest_for(account)
      end
    end
  end

  private

  def calculate_interest_for(account)
    # Simple interest calculation: Balance * Rate / 100
    # In a real app, this might be daily/monthly. Here it's a "trigger" event.
    interest_amount = (account.balance * account.interest_rate / 100.0).round(2)

    if interest_amount > 0
      account.with_lock do
        account.balance += interest_amount
        account.save!

        LedgerEntry.create!(
          account: account,
          amount: interest_amount,
          entry_type: 'interest'
        )
      end
    end
  end
end
