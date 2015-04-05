class Admin::RewardTransactionsController < AdminController
  before_action :set_reward_transaction

  def edit
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to admin_dashboard_path
      flash[:notice] = "Transaction updated"
    end
  end

  private

  def set_reward_transaction
    @transaction = RewardTransaction.find(params[:id])
  end

  def transaction_params
    params.require(:reward_transaction).permit(:paid)
  end
end