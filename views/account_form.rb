class AccountForm
  def initialize
    @user_input = UserInput.new
    @console_print = ConsolePrint.new
  end

  def form_deposit
    loop do
      @console_print.blue_message message:'ingrese la cantidad de dinero que desea depositar: '
      break if @user_input.validate_amount_input
    end
    @user_input.last_input.to_i
  end

  def form_withdraw
    loop do
      @console_print.blue_message message:'ingrese la cantidad de dinero que desea retirar: '
      break if @user_input.validate_amount_input
    end
    @user_input.last_input.to_i
  end

  def form_transfer
    loop do
      @console_print.blue_message message:'Direccion de correo a la cual desea enviar el dinero: '
      break if @user_input.validate_user_data_input(field: 'email')
    end
    email = @user_input.last_input
    loop do
      @console_print.blue_message message:'ingrese la cantidad de dinero que desea enviar: '
      break if @user_input.validate_amount_input
    end
    amount = @user_input.last_input.to_i
    { email: email, amount: amount }
  end
end
