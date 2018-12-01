class MenuOption
  def initialize(user:, user_menu:)
    @user = user
    @user_menu = user_menu
    @transaction = Transaction.new(user: @user)
  end

  def do(option_number:, menu_type:)
    return user_menu_option(option_number.to_i) if menu_type == 'user'
    return mattress_menu_option(option_number.to_i) if menu_type == 'mattress'
    return pocket_menu_option(option_number.to_i) if menu_type == 'pocket'
    return goal_menu_option(option_number.to_i) if menu_type == 'goal'
    true
  end

  private

  def user_menu_option(option_number)
    puts "\nDinero disponible en la cuenta: #{@user.account.available}" if option_number == 1
    puts "\nDinero Total en la cuenta: #{@user.total_balance}" if option_number == 2
    @transaction.deposit(type: 'account') if option_number == 3
    @transaction.withdraw(type: 'account') if option_number == 4
    @transaction.transfer(type: 'account') if option_number == 5
    @transaction.list_transactions if option_number == 6
    @user_menu.mattress_menu if option_number == 7
    @user_menu.pocket_menu if option_number == 8
    @user_menu.pocket_menu if option_number == 9
    return false if option_number == 10
    true
  end

  def mattress_menu_option(option_number)
    puts "\nDinero ahorrado en el colchon: #{@user.mattress.save_money}" if option_number == 1
    @transaction.deposit(type: 'mattress') if option_number == 2
    @transaction.withdraw(type: 'mattress') if option_number == 3
    return false if option_number == 4
    true
  end

  def pocket_menu_option(option_number)
    puts @user.list_pockets if option_number == 1
    create_pocket if option_number == 2
    delete_pocket if option_number == 3
    @transaction.deposit(type: 'pocket') if option_number == 4
    @transaction.withdraw(type: 'pocket') if option_number == 5
    @transaction.transfer(type: 'pocket') if option_number == 6
    return false if option_number == 7
    true
  end

  def goal_menu_option(option_number)
    puts @user.list_goals if option_number == 1
    create_goal if option_number == 2
    delete_goal if option_number == 3
    @transaction.deposit(type: 'goal') if option_number == 4
    return false if option_number == 5
    true
  end

  def create_pocket
    begin
      print 'Nombre del bolsillo: '
    end while !@user_input.validate_user_data_input(field: 'name')
    name = @user_input.last_input
    @user.add_pocket(name)
    puts "\nEl bolsillo #{name} ha sido creado con exito!"
  end

  def delete_pocket
    begin
      print 'Nombre del bolsillo a eliminar: '
    end while !@user_input.validate_user_data_input(field: 'name')
    name = @user_input.last_input
    if !@user.search_pocket(name).nil?
      @user.search_pocket(name).delete(@user.account)
      puts "\nEl bolsillo #{name} ha sido eliminado, el saldo ahora esta disponible en la cuenta"
    else
      puts "\nEl bolsillo #{name} no existe"
    end
  end

  def create_goal
    begin
      print 'Nombre de la meta: '
    end while !@user_input.validate_user_data_input(field: 'name')
    name = @user_input.last_input
    begin
      print 'Ingrese la meta de dinero: '
    end while !@user_input.validate_amount_input
    expected_amount = @user_input.last_input

    puts 'Por favor ingrese el año, el mes y el dia de vencimiento de la meta en numeros'
    begin
      print 'Ingrese el plazo maximo de la meta (año): '
    end while !@user_input.validate_date_input(type: 'year')
    year = @user_input.last_input.to_i
    begin
      print 'Ingrese el plazo maximo de la meta (mes): '
    end while !@user_input.validate_date_input(type: 'month')
    month = @user_input.last_input.to_i
    begin
      print 'Ingrese el plazo maximo de la meta (dia): '
    end while !@user_input.validate_date_input(type: 'day')

    @user.add_goal(name, expected_amount, year, month, day)
    puts "\nLa meta #{name} ha sido creado con exito!"
  end

  def delete_goal
    begin
      print 'Nombre de la meta a eliminar: '
    end while !@user_input.validate_user_data_input(field: 'name')
    name = @user_input.last_input
    if !@user.search_goal(name).nil?
      puts "La meta #{name} ha sido cerrada con exito, el dinero esta disponible en la cuenta"
      @user.search_goal(name).delete(@user.account)
    else
      puts "\nLa meta #{name} no existe"
    end
  end
end
