class AccountController
  def initialize(user:)
    @user = user
    @form = AccountForm.new
    @console_print = ConsolePrint.new      
  end

  def available
    @user.account.update_available_money
    @console_print.blue_message message:"\nDinero disponible en la cuenta: "
    @console_print.money_amount amount:@user.account.available.to_s
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def balance_total
    @user.account.update_available_money
    @console_print.blue_message message:"\nDinero Total en la cuenta: "
    @console_print.money_amount amount:@user.total_balance.to_s
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def deposit
    amount = @form.form_deposit
    @user.account.deposit(amount)
    @console_print.success_message message:"\nDinero depositado con exito!"
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def withdraw
    amount = @form.form_withdraw
    if @user.account.withdraw(amount)
      @console_print.success_message message:"\nRetiro realizado con exito!"
    else
      @console_print.error error:"\nLa cantidad a retirar no esta disponible en su cuenta"
    end
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def transfer
    data = nil
    loop do
      data = @form.form_transfer
      break if data[:email] != @user.email
      @console_print.message message:'No te puedes enviar dinero a ti mismo'
    end
    if @user.account.transfer_money(data[:email], data[:amount])
      @console_print.success_message message:"\nEnvio realizado con exito!"
    else
      @console_print.error error:"\nLa cantidad a enviar no esta disponible en su cuenta\no el correo especificado no tiene una cuenta registrada"
    end
    @console_print.wait_for_enter
    @console_print.clear_console
  end
end
