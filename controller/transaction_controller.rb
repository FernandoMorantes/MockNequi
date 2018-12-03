# user transactions controller
class TransactionController < ConsolePrint
  def initialize(user:)
    @user = user
    @user_input = UserInput.new
    @view = TransactionView.new
  end

  def list_transactions
    n_transactions = @view.form_list
    print_blue_bold "\nUltimas #{n_transactions} transacciones:"
    transactions = @user.list_transactions(n_transactions.to_i)
    @view.print_transactions(transactions)
    print_cyan "\n Solo has realizado #{transactions.size} transacciones \n\n" if transactions.size < n_transactions.to_i
  end
end
