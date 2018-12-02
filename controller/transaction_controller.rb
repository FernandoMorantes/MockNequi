class TransactionController

  def initialize(user:)
    @user = user
    @user_input = UserInput.new
    @view = TransactionView.new
  end

  def list_transactions
    n_transactions =  @view.form_list
    puts "\nUltimas #{n_transactions} transacciones:"
    transactions = @user.list_transactions(n_transactions.to_i)
    @view.print_transactions(transactions)
  end
end
