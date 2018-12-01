class MenuOption

  def initialize (user:, user_menu:)
    @user = user
    @user_menu = user_menu
    @transaction = Transaction.new(user: @user)
  end
  def do(option_number:, menu_type:)
    user_menu_option(option_number.to_i) if menu_type == 'user'
    mattress_menu_option(option_number.to_i) if menu_type == 'mattress'
    pocket_menu_option(option_number.to_i) if menu_type == 'pocket'
    goal_menu_option(option_number.to_i) if menu_type == 'goal'
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
    @option = 'listar bolsillos' if option_number == 1
    @option = 'crear un nuevo bolsillo' if option_number == 2
    @option = 'eliminar un bolsillo' if option_number == 3
    @option = 'agregar dinero a un bolsillo' if option_number == 4
    @option = 'retirar dinero de un bolsillo' if option_number == 5
    @option = 'enviar dinero a otro usuario' if option_number == 6
    @option = 'regresar al menu de usuario' if option_number == 7
  end

  def goal_menu_option(option_number)
    @option = 'listar metas' if option_number == 1
    @option = 'crear una nueva meta' if option_number == 2
    @option = 'cerrar una meta' if option_number == 3
    @option = 'agregar dinero a una meta' if option_number == 4
    @option = 'regresar al menu de usuario' if option_number == 5
  end
end
