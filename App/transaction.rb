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

  def withdraw(type:)
    deposit_account if type == 'account'
    deposit_mattress if type == 'mattress'
    deposit_goal if type == 'goal'
    deposit_pocket if type == 'pocket'
  end

  def deposit(type:); end

  def transfer(type:); end

  private

  def deposit_account
    begin
      print 'ingrese la cantidad de dinero que desea depositar: '
    end while !@user_input.validate_amount_input
    amount = @user_input.last_input
    @user.account.deposit(amount.to_i)
    puts "\nDinero depositado con exito!"
  end

  def deposit_mattress
    begin
      print 'ingrese la cantidad de dinero que desea guardar en el colchon: '
    end while !@user_input.validate_amount_input
    amount = @user_input.last_input
    if @user.mattress.deposit(amount.to_i)
      @user.account.available -= amount
      puts "\nDinero depositado con exito!"
    else
      puts "\nLa cantidad a depositar no esta disponible en su cuenta"
    end
  end

  def withdraw_account
    begin
      print 'ingrese la cantidad de dinero que desea retirar: '
    end while !@user_input.validate_amount_input
    amount = @user_input.last_input
    if @user.account.withdraw(amount.to_i)
      puts "\nRetiro realizado con exito!"
    else
      puts "\nLa cantidad a retirar no esta disponible en su cuenta"
    end
  end

  def withdraw_mattres
    begin
      print 'ingrese la cantidad de dinero que desea retirar del colchon: '
    end while !@user_input.validate_amount_input
    amount = @user_input.last_input
    if @user.mattress.withdraw(amount.to_i)
      @user.account.available += amount
      puts "\nRetiro realizado con exito!"
    else
      puts "\nLa cantidad a retirar no esta disponible en el colchon"
    end
  end

  def transfer_account
    begin
      print 'Direccion de correo a la cual desea enviar el dinero: '
    end while !@user_input.validate_user_data_input(field: 'email')
    email = @user_input.last_input
    begin
      print 'ingrese la cantidad de dinero que desea enviar: '
    end while !@user_input.validate_amount_input
    amount = @user_input.last_input
    if @user.account.transfer_money(email, amount.to_i)
      puts "\nEnvio realizado con exito!"
    else
      puts "\nLa cantidad a enviar no esta disponible en su cuenta\no el correo especificado no tiene una cuenta registrada"
    end
  end
end
