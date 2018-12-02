class MenuOption
  def initialize(user:, user_menu:)
    @user = user
    @user_menu = user_menu
    @account_controller = AccountController.new(user: @user)
    @mattress_controller = MattressController.new(user: @user)
    @pocket_controller = PocketController.new(user: @user)
    @goal_controller = GoalController.new(user: @user)
    @transaction_controller = TransactionController.new(user: user)
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
    @account_controller.deposit if option_number == 3
    @account_controller.withdraw if option_number == 4
    @account_controller.transfer if option_number == 5
    @transaction_controller.list_transactions if option_number == 6
    @user_menu.mattress_menu if option_number == 7
    @user_menu.pocket_menu if option_number == 8
    @user_menu.goal_menu if option_number == 9
    return false if option_number == 10
    true
  end

  def mattress_menu_option(option_number)
    @mattress_controller.available if option_number == 1
    @mattress_controller.deposit if option_number == 2
    @mattress_controller.withdraw if option_number == 3
    return false if option_number == 4
    true
  end

  def pocket_menu_option(option_number)
    @pocket_controller.list if option_number == 1
    @pocket_controller.create if option_number == 2
    @pocket_controller.delete if option_number == 3
    @pocket_controller.deposit if option_number == 4
    @pocket_controller.withdraw if option_number == 5
    @pocket_controller.transfer if option_number == 6
    return false if option_number == 7
    true
  end

  def goal_menu_option(option_number)
    @goal_controller.list if option_number == 1
    @goal_controller.create if option_number == 2
    @goal_controller.delete if option_number == 3
    @goal_controller.deposit if option_number == 4
    return false if option_number == 5
    true
  end
end
