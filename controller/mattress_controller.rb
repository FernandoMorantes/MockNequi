class MattressController
  def initialize(user:)
    @user_input = UserInput.new
    @user = user
  end

  def deposit
    amount = @form.form_deposit
    if @user.mattress.deposit(amount, @user.account.available)
      @user.account.available -= amount
      puts "\nDinero depositado con exito!"
    else
      puts "\nLa cantidad a depositar no esta disponible en su cuenta"
    end
  end

  def withdraw
    amount = @form.form_withdraw
    if @user.mattress.withdraw(amount)
      @user.account.available += amount
      puts "\nRetiro realizado con exito!"
    else
      puts "\nLa cantidad a retirar no esta disponible en el colchon"
    end
  end
end
