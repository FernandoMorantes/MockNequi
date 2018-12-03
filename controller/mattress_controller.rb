class MattressController
  def initialize(user:)
    @user = user
    @form = AccountForm.new
    @console_print = ConsolePrint.new
  end

  def available
    @console_print.blue_message message:"\nDinero ahorrado en el colchon: "
    @console_print.money_amount amount:@user.mattress.save_money.to_s
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def deposit
    amount = @form.form_deposit
    if @user.mattress.deposit(amount, @user.account.available)
      @user.account.available -= amount
      @console_print.success_message message:"\nDinero depositado con exito!"
    else
      @console_print.error error:"\nLa cantidad a depositar no esta disponible en su cuenta"
    end
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def withdraw
    amount = @form.form_withdraw
    if @user.mattress.withdraw(amount)
      @user.account.available += amount
      @console_print.success_message message:"\nRetiro realizado con exito!"
    else
      @console_print.error error:"\nLa cantidad a retirar no esta disponible en el colchon"
    end
    @console_print.wait_for_enter
    @console_print.clear_console
  end
end
