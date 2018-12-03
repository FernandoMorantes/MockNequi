class TransactionController
  def initialize(user:)
    @user = user
    @user_input = UserInput.new
    @view = TransactionView.new
    @console_print = ConsolePrint.new 
  end

  def list_transactions
    n_transactions = @view.form_list
    @console_print.title title:"\nUltimas #{n_transactions} transacciones:"
    transactions = @user.list_transactions(n_transactions.to_i)
    @view.print_transactions(transactions)
    @console_print.cyan_message message:"\n Solo has realizado #{transactions.size} transacciones \n\n" if transactions.size < n_transactions.to_i
    @console_print.wait_for_enter
    @console_print.clear_console
  end
end
