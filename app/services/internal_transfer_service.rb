class InternalTransferService
  class TransferError < StandardError; end

  def initialize(source_account, target_account, amount)
    @source = source_account
    @target = target_account
    @amount = amount
  end

  def call
    # 1. Start a Database Transaction (All or Nothing)
    ActiveRecord::Base.transaction do
      # 2. DEADLOCK PREVENTION: 
      # Always lock the account with the lower ID first.
      # This ensures all processes wait in the same line.
      first, second = [@source, @target].sort_by(&:id)
      
      first.lock!
      second.lock!

      # 3. Validation
      validate_transfer!

      # 4. Perform the logic (Creating Ledger Entries)
      # We define negative for source, positive for target
      create_ledger_entry(@source, -@amount, :transfer_out)
      create_ledger_entry(@target, @amount, :transfer_in)

      # 5. Update Cached Balances (Triggers Turbo Broadcasts defined in Account model)
      @source.update!(balance: @source.balance - @amount)
      @target.update!(balance: @target.balance + @amount)
    end
    
    # If we get here, the transaction committed successfully
    return true
  rescue TransferError => e
    # Bubble up error to controller
    raise e
  end

  private

  def validate_transfer!
    if @source.balance < @amount
      raise TransferError, "Insufficient funds in #{@source.class.name}"
    end
  end

  def create_ledger_entry(account, amount, type)
    account.ledger_entries.create!(
      amount: amount,
      entry_type: type,
      # occurred_at handled by timestamps
    )
  end
end
