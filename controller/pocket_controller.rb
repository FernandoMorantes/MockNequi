class PocketController
  def initialize(user:)
    @user = user
    @form = PocketForm.new
    @console_print = ConsolePrint.new
  end

  def list
    @console_print.message message:@user.list_pockets
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def deposit
    data = nil
    loop do
      data = @form.form_deposit
      break unless @user.search_pocket(data[:name]).nil?
      @console_print.error error:"\nEl bolsillo #{data[:name]} no existe"
    end
    if @user.search_pocket(data[:name]).deposit(data[:amount], @user.account.available)
      @user.account.available -= data[:amount]
      @console_print.success_message message:"\nDinero depositado en el bolisllo #{data[:name]} con exito!"
    else
      @console_print.error error:"\nLa cantidad a depositar no esta disponible en su cuenta"
    end
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def withdraw
    data = nil
    loop do
      data = @form.form_deposit
      break unless @user.search_pocket(data[:name]).nil?
      @console_print.error error:"\nEl bolsillo #{data[:name]} no existe"
    end
    if @user.search_pocket(data[:name]).withdraw(data[:amount])
      @user.account.available += data[:amount]
      @console_print.success_message message:"\nDinero retirado del bolsillo #{data[:name]} con exito!"
    else
      @console_print.error error:"\nLa cantidad a retirar no esta disponible en el bolsillo #{name}"
    end
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def transfer
    data = nil
    loop do
      data = @form.form_transfer
      if data[:email] == @user.email
        @console_print.message message:'No te puedes enviar dinero a ti mismo'
      else
        break unless @user.search_pocket(data[:name]).nil?
        @console_print.error error:"\nEl bolsillo #{data[:name]} no existe"
      end
    end
    if @user.search_pocket(data[:name]).transfer_money(data[:email], data[:amount])
      @console_print.success_message message:"\nEnvio realizado con exito!"
    else
      @console_print.error error:"\nLa cantidad a enviar no esta disponible el bolsillo\no el correo especificado no tiene una cuenta registrada"
    end
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def create
    name = @form.form_create
    if @user.add_pocket(name)
      @console_print.success_message message:"\nEl bolsillo #{name} ha sido creado con exito!"
    else
      @console_print.error error:"\nNo puedes crear otro bolsillo llamado #{name}"
    end
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def delete
    name = @form.form_delete
    if !@user.search_pocket(name).nil?
      pocket_balance = @user.search_pocket(name).delete
      @user.account.available += pocket_balance
      @console_print.success_message message:"\nEl bolsillo #{name} ha sido eliminado, el saldo ahora esta disponible en la cuenta"
    else
      @console_print.error error:"\nEl bolsillo #{name} no existe"
    end
    @console_print.wait_for_enter
    @console_print.clear_console
  end
end
