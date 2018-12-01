class PocketController
  def initialize(user:)
    @user_input = UserInput.new
    @user = user
    @form = PocketForm.new
  end

  def deposit
    loop do
      data = @form.form_deposit
      break unless @user.search_pocket(data[:name]).nil?
      puts "\nEl bolsillo #{data[:name]} no existe"
    end
    if @user.search_pocket(data[:name]).deposit(data[:amount], @user.account.available)
      @user.account.available -= amount
      puts "\nDinero depositado en el bolisllo #{name} con exito!"
    else
      puts "\nLa cantidad a depositar no esta disponible en su cuenta"
    end
  end

  def withdraw
    loop do
      data = @form.form_deposit
      break unless @user.search_pocket(data[:name]).nil?
      puts "\nEl bolsillo #{data[:name]} no existe"
    end
    if @user.search_pocket(data[:name]).withdraw(data[:amount])
      @user.account.available += amount
      puts "\nDinero retirado del bolsillo #{data[:name]} con exito!"
    else
      puts "\nLa cantidad a retirar no esta disponible en el bolsillo #{name}"
    end
  end

  def transfer
    loop do
      data = @form.form_transfer
      if data[:email] == @user.email
        puts 'No te puedes enviar dinero a ti mismo'
      else
        break unless @user.search_pocket(data[:name]).nil?
        puts "\nEl bolsillo #{data[:name]} no existe"
      end
    end
    if @user.search_pocket(data[:name]).transfer_money(data[:email], data[:amount])
      puts "\nEnvio realizado con exito!"
    else
      puts "\nLa cantidad a enviar no esta disponible el bolsillo\no el correo especificado no tiene una cuenta registrada"
    end
  end

  def create
    name = @form.form_create
    @user.add_pocket(name)
    puts "\nEl bolsillo #{name} ha sido creado con exito!"
  end

  def delete
    name = @form.form_delete
    if !@user.search_pocket(name).nil?
      pocket_balance = @user.search_pocket(name).delete
      @user.account.available += pocket_balance
      puts "\nEl bolsillo #{name} ha sido eliminado, el saldo ahora esta disponible en la cuenta"
    else
      puts "\nEl bolsillo #{name} no existe"
    end
  end
end
