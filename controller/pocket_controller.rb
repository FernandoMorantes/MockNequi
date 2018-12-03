class PocketController < ConsolePrint
  def initialize(user:)
    @user = user
    @form = PocketForm.new
  end

  def list
    print_blue @user.list_pockets
    wait_for_enter
    clear_console
  end

  def deposit
    data = nil
    loop do
      data = @form.form_deposit
      break unless @user.search_pocket(data[:name]).nil?
      print_red_bold "\nEl bolsillo #{data[:name]} no existe"
    end
    if @user.search_pocket(data[:name]).deposit(data[:amount], @user.account.available)
      @user.account.available -= data[:amount]
      print_green_bold "\nDinero depositado en el bolisllo #{data[:name]} con exito!"
    else
      print_red_bold "\nLa cantidad a depositar no esta disponible en su cuenta"
    end
    wait_for_enter
    clear_console
  end

  def withdraw
    data = nil
    loop do
      data = @form.form_deposit
      break unless @user.search_pocket(data[:name]).nil?
      print_red_bold "\nEl bolsillo #{data[:name]} no existe"
    end
    if @user.search_pocket(data[:name]).withdraw(data[:amount])
      @user.account.available += data[:amount]
      print_green_bold "\nDinero retirado del bolsillo #{data[:name]} con exito!"
    else
      print_red_bold "\nLa cantidad a retirar no esta disponible en el bolsillo #{name}"
    end
    wait_for_enter
    clear_console
  end

  def transfer
    data = nil
    loop do
      data = @form.form_transfer
      if data[:email] == @user.email
        print_brown 'No te puedes enviar dinero a ti mismo'
      else
        break unless @user.search_pocket(data[:name]).nil?
        print_red_bold "\nEl bolsillo #{data[:name]} no existe"
      end
    end
    if @user.search_pocket(data[:name]).transfer_money(data[:email], data[:amount])
      print_green_bold "\nEnvio realizado con exito!"
    else
      print_red_bold "\nLa cantidad a enviar no esta disponible el bolsillo\no el correo especificado no tiene una cuenta registrada"
    end
    wait_for_enter
    clear_console
  end

  def create
    name = @form.form_create
    @user.add_pocket(name)
    print_green_bold "\nEl bolsillo #{name} ha sido creado con exito!"
    wait_for_enter
    clear_console
  end

  def delete
    name = @form.form_delete
    if !@user.search_pocket(name).nil?
      pocket_balance = @user.search_pocket(name).delete
      @user.account.available += pocket_balance
      print_green_bold "\nEl bolsillo #{name} ha sido eliminado, el saldo ahora esta disponible en la cuenta"
    else
      print_red_bold "\nEl bolsillo #{name} no existe"
    end
    wait_for_enter
    clear_console
  end
end
