class PocketController

  def initialize(user:)
    @user_input = UserInput.new
    @user = user
  end

  def deposit
    begin
      print 'Nombre del bolsillo: '
    end while !@user_input.validate_user_data_input(field: 'name')
    name = @user_input.last_input
    if !@user.search_pocket(name).nil?
      begin
        print 'ingrese la cantidad de dinero que desea guardar en el bolsillo: '
      end while !@user_input.validate_amount_input
      amount = @user_input.last_input.to_i
      if @user.search_pocket(name).deposit(amount, @user.account.available)
        @user.account.available -= amount
        puts "\nDinero depositado en el bolisllo #{name} con exito!"
      else
        puts "\nLa cantidad a depositar no esta disponible en su cuenta"
      end
    else
      puts "\nEl bolsillo #{name} no existe"
    end
  end
  
  def withdraw
    begin
      print 'Nombre del bolsillo: '
    end while !@user_input.validate_user_data_input(field: 'name')
    name = @user_input.last_input
    if !@user.search_pocket(name).nil?
      begin
        print 'ingrese la cantidad de dinero que desea retirar del bolsillo: '
      end while !@user_input.validate_amount_input
      amount = @user_input.last_input.to_i.to_i
      if @user.search_pocket(name).withdraw(amount)
        @user.account.available += amount
        puts "\nDinero retirado del bolsillo #{name} con exito!"
      else
        puts "\nLa cantidad a retirar no esta disponible en el bolsillo #{name}"
      end
    else
      puts "\nEl bolsillo #{name} no existe"
    end
  end

  def transfer
    begin
    print 'Nombre del bolsillo: '
  end while !@user_input.validate_user_data_input(field: 'name')
    name = @user_input.last_input
    if !@user.search_pocket(name).nil?
      begin
        print 'Direccion de correo a la cual desea enviar el dinero: '
        puts 'No te puedes enviar dinero a ti mismo' if @user_input.last_input == @user.email
      end while !(@user_input.validate_user_data_input(field: 'email')) || @user_input.last_input != @user.email
      email = @user_input.last_input
      begin
        print 'ingrese la cantidad de dinero que desea enviar: '
      end while !@user_input.validate_amount_input
      amount = @user_input.last_input
      if @user.search_pocket(name).transfer_money(email, amount.to_i)
        puts "\nEnvio realizado con exito!"
      else
        puts "\nLa cantidad a enviar no esta disponible el bolsillo\no el correo especificado no tiene una cuenta registrada"
      end
    else
      puts "\nEl bolsillo #{name} no existe"
    end
  end

  def create
    begin
      print 'Nombre del bolsillo: '
    end while !@user_input.validate_user_data_input(field: 'name')
    name = @user_input.last_input
    @user.add_pocket(name)
    puts "\nEl bolsillo #{name} ha sido creado con exito!"
  end

  def delete
    begin
      print 'Nombre del bolsillo a eliminar: '
    end while !@user_input.validate_user_data_input(field: 'name')
    name = @user_input.last_input
    if !@user.search_pocket(name).nil?
      pocket_balance = @user.search_pocket(name).delete
      @user.account.available += pocket_balance
      puts "\nEl bolsillo #{name} ha sido eliminado, el saldo ahora esta disponible en la cuenta"
    else
      puts "\nEl bolsillo #{name} no existe"
    end
  end
end