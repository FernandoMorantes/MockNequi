class PocketForm < ConsolePrint
  def initialize
    @user_input = UserInput.new
  end

  def form_deposit
    loop do
      print 'Nombre del bolsillo: '
      break if @user_input.validate_user_data_input(field: 'name')
    end
    name = @user_input.last_input
    loop do
      print 'ingrese la cantidad de dinero que desea guardar en el bolsillo: '
      break if @user_input.validate_amount_input
    end
    amount = @user_input.last_input.to_i
    { name: name, amount: amount }
   end

  def form_withdraw
    loop do
      print 'Nombre del bolsillo: '
      break if @user_input.validate_user_data_input(field: 'name')
    end
    name = @user_input.last_input
    loop do
      print 'ingrese la cantidad de dinero que desea retirar del bolsillo: '
      break if @user_input.validate_amount_input
    end
    amount = @user_input.last_input.to_i
    { name: name, amount: amount }
  end

  def form_transfer
    loop do
      print 'Nombre del bolsillo: '
      break if @user_input.validate_user_data_input(field: 'name')
    end
    name = @user_input.last_input
    loop do
      print 'Direccion de correo a la cual desea enviar el dinero: '
      break if @user_input.validate_user_data_input(field: 'email')
    end
    email = @user_input.last_input
    loop do
      print 'ingrese la cantidad de dinero que desea enviar: '
      break if @user_input.validate_amount_input
    end
    amount = @user_input.last_input.to_i
    { name: name, email: email, amount: amount }
  end

  def form_create
    loop do
      print 'Nombre del bolsillo: '
      break if @user_input.validate_user_data_input(field: 'name')
    end
    @user_input.last_input
  end

  def form_delete
    loop do
      print 'Nombre del bolsillo a eliminar: '
      break if @user_input.validate_user_data_input(field: 'name')
    end
    @user_input.last_input
  end
end
