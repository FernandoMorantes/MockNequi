class TransactionView < ConsolePrint
  def initialize
    @user_input = UserInput.new
  end

  def form_list
    loop do
      print_blue 'ingrese la cantidad de transacciones que desea consultar: '
      break if @user_input.validate_amount_input
    end
    @user_input.last_input
  end

  def print_transactions(transactions)
    puts
    print_purple_bold 'Tipo de trasaccion'.center(30)
    print_purple_bold 'Monto'.center(30)
    print_purple_bold 'Fecha'.center(30)
    puts
    transactions.each do |trasaction|
      print_brown type_trasaction_translate(trasaction['type'].to_s).center(30)
      color_amount(trasaction['amount'], trasaction['type'])
      print_brown trasaction['transaction_date'].strftime('%a %d %b %Y %I:%M:%S %P').center(30)
      puts
    end
  end

  private

  def color_amount(amount, type_trasaction)
    print_red "- $ #{format_money(amount.to_s)}".to_s.center(30) if %w[withdraw sending].include? type_trasaction
    print_green "+ $ #{format_money(amount.to_s)}".to_s.center(30) if %w[deposit reception].include? type_trasaction
  end

  def type_trasaction_translate(type_transaction)
    return 'Deposito' if type_transaction == 'deposit'
    return 'Retiro' if type_transaction == 'withdraw'
    return 'Recepcion' if type_transaction == 'reception'
    return 'Envio' if type_transaction == 'sending'
  end
end
