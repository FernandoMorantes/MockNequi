class MattressController < ConsolePrint
  def initialize(user:)
    @user = user
    @form = MattressForm.new
  end

  def available
    print_blue "\nDinero ahorrado en el colchon: "
    print_money @user.mattress.save_money.to_s
    wait_for_enter
    clear_console
  end

  def deposit
    amount = @form.form_deposit
    if @user.mattress.deposit(amount, @user.account.available)
      @user.account.available -= amount
      print_green_bold "\nDinero depositado con exito!"
    else
      print_red_bold "\nLa cantidad a depositar no esta disponible en su cuenta"
    end
    wait_for_enter
    clear_console
  end

  def withdraw
    amount = @form.form_withdraw
    if @user.mattress.withdraw(amount)
      @user.account.available += amount
      print_green_bold "\nRetiro realizado con exito!"
    else
      print_red_bold "\nLa cantidad a retirar no esta disponible en el colchon"
    end
    wait_for_enter
    clear_console
  end
end
