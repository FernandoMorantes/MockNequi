class AccountController < ConsolePrint
  def initialize(user:)
    @user = user
    @form = AccountForm.new
  end

  def available
    @user.account.update_available_money
    print_blue "\nDinero disponible en la cuenta: "
    print_money @user.account.available.to_s
    wait_for_enter
    clear_console
  end

  def balance_total
    @user.account.update_available_money
    print_blue "\nDinero Total en la cuenta: "
    print_money @user.total_balance.to_s
    wait_for_enter
    clear_console
  end

  def deposit
    amount = @form.form_deposit
    @user.account.deposit(amount)
    print_green_bold "\nDinero depositado con exito!"
    wait_for_enter
    clear_console
  end

  def withdraw
    amount = @form.form_withdraw
    if @user.account.withdraw(amount)
      print_green_bold "\nRetiro realizado con exito!"
    else
      print_red_bold "\nLa cantidad a retirar no esta disponible en su cuenta"
    end
    wait_for_enter
    clear_console
  end

  def transfer
    data = nil
    loop do
      data = @form.form_transfer
      break if data[:email] != @user.email
      puts 'No te puedes enviar dinero a ti mismo'
    end
    if @user.account.transfer_money(data[:email], data[:amount])
      print_green_bold "\nEnvio realizado con exito!"
    else
      print_red_bold "\nLa cantidad a enviar no esta disponible en su cuenta\no el correo especificado no tiene una cuenta registrada"
    end
    wait_for_enter
    clear_console
  end
end
