class TransfersController < ApplicationController
  def create
    # In a real app, use current_user.accounts.find...
    # For demo simplicity, we might trust params or assume current_user is set.
    # We'll assume a current_user method exists (simulated or real).
    
    source = current_user.accounts.find(params[:source_id])
    target = current_user.accounts.find(params[:target_id])
    amount = params[:amount].to_d
    
    begin
      InternalTransferService.new(source, target, amount).call
      
      respond_to do |format|
        format.turbo_stream { 
          render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash", locals: { notice: "Transfer Complete" }) 
        }
        format.html { redirect_to root_path, notice: "Transfer Complete" }
      end
    rescue InternalTransferService::TransferError => e
      respond_to do |format|
        format.turbo_stream { 
          render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash", locals: { alert: e.message }) 
        }
        format.html { redirect_to root_path, alert: e.message }
      end
    end
  end
end
