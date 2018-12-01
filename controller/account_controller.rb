class AccountController
  def initialize(user:)
    @user_input = UserInput.new
    @user = user
    @form = AccountForm.new
  end

  def deposit
    amount = @form.form_deposit
    @user.account.deposit(amount)
    puts "\nDinero depositado con exito!"
  end

  def withdraw
    amount = @form.form_withdraw
    if @user.account.withdraw(amount)
      puts "\nRetiro realizado con exito!"
    else
      puts "\nLa cantidad a retirar no esta disponible en su cuenta"
    end
  end

  def transfer
    data = @form.form_transfer
    if @user.account.transfer_money(data[:email], data[:amount])
      puts "\nEnvio realizado con exito!"
    else
      puts "\nLa cantidad a enviar no esta disponible en su cuenta\no el correo especificado no tiene una cuenta registrada"
    end
  end
end
