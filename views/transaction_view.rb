class TransactionView < ConsolePrint
  def initialize
    @user_input = UserInput.new
    @console_print = ConsolePrint.new
  end

  def form_list
    loop do
      @console_print.blue_message message:'ingrese la cantidad de transacciones que desea consultar: '
      break if @user_input.validate_amount_input
    end
    @user_input.last_input
  end

  def print_transactions(transactions)
    puts
    @console_print.transaction_title title:'Tipo de trasaccion'.center(30)
    @console_print.transaction_title title:'Monto'.center(30)
    @console_print.transaction_title title:'Fecha'.center(30)
    puts
    transactions.each do |trasaction|
      @console_print.transaction_info info:type_trasaction_translate(trasaction['type'].to_s).center(30)
      color_amount(trasaction['amount'], trasaction['type'])
      @console_print.transaction_info info:trasaction['transaction_date'].strftime('%a %d %b %Y %I:%M:%S %P').center(30)
      puts
    end
  end

  private

  def color_amount(amount, type_trasaction)
    @console_print.transaction_withdraw amount:"- $ #{format_money(amount.to_s)}".to_s.center(30) if %w[withdraw sending].include? type_trasaction
    @console_print.transaction_deposit amount:"+ $ #{format_money(amount.to_s)}".to_s.center(30) if %w[deposit reception].include? type_trasaction
  end

  def type_trasaction_translate(type_transaction)
    return 'Deposito' if type_transaction == 'deposit'
    return 'Retiro' if type_transaction == 'withdraw'
    return 'Recepcion' if type_transaction == 'reception'
    return 'Envio' if type_transaction == 'sending'
  end
end
