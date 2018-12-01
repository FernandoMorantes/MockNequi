class Transaction

  def initialize(user:)
    @user = user
    @user_input = UserInput.new
  end

  def list_transactions
    begin
      print 'ingrese la cantidad de transacciones que desea consultar: '
    end while !@user_input.validate_amount_input
    n_transactions = @user_input.last_input
    puts "\nUltimas #{n_transactions} transacciones:"
    @user.list_transactions(n_transactions.to_i)
  end
end
