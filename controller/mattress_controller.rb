class MattressController

  def initialize(user:)
    @user_input = UserInput.new
    @user = user
  end

  def deposit
    begin
      print 'ingrese la cantidad de dinero que desea guardar en el colchon: '
    end while !@user_input.validate_amount_input
    amount = @user_input.last_input.to_i
    if @user.mattress.deposit(amount, @user.account.available)
      @user.account.available -= amount
      puts "\nDinero depositado con exito!"
    else
      puts "\nLa cantidad a depositar no esta disponible en su cuenta"
    end
  end

  def withdraw
    begin
      print 'ingrese la cantidad de dinero que desea retirar del colchon: '
    end while !@user_input.validate_amount_input
    amount = @user_input.last_input.to_i.to_i
    if @user.mattress.withdraw(amount)
      @user.account.available += amount
      puts "\nRetiro realizado con exito!"
    else
      puts "\nLa cantidad a retirar no esta disponible en el colchon"
    end
  end
end
