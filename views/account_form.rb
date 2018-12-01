class AccountForm
  def initialize; end

  def form_deposit
    begin
      print 'ingrese la cantidad de dinero que desea depositar: '
    end while !@user_input.validate_amount_input
    @user_input.last_input.to_i
  end

  def form_withdraw
    begin
      print 'ingrese la cantidad de dinero que desea retirar: '
    end while !@user_input.validate_amount_input
    @user_input.last_input.to_i
  end

  def form_transfer
    begin
      print 'Direccion de correo a la cual desea enviar el dinero: '
      puts 'No te puedes enviar dinero a ti mismo' if @user_input.last_input == @user.email
    end while !@user_input.validate_user_data_input(field: 'email') || @user_input.last_input != @user.email
    email = @user_input.last_input
    begin
      print 'ingrese la cantidad de dinero que desea enviar: '
    end while !@user_input.validate_amount_input
    amount = @user_input.last_input.to_i
    { email: email, amount: amount }
  end
end
