class UserMenu
  def initialize(user:, session:)
    @user = user
    @session = session
    @user_input = UserInput.new
    @menus_ui = MenusUI.new
    @menu_option = MenuOption.new(user: @user, user_menu: self)
    @console_print = ConsolePrint.new
  end

  def show
    loop do
      loop do
        @menus_ui.show_user_menu
        break if @user_input.validate_menu_input(menu_type: 'user')
      end
      break unless @menu_option.do(menu_type: 'user', option_number: @user_input.last_input)
    end
    @console_print.mock_loading message:'Cerrando sesion'
    @console_print.clear_console
  end

  def mattress_menu
    @console_print.clear_console
    loop do
      loop do
        @menus_ui.show_mattress_menu
        break if @user_input.validate_menu_input(menu_type: 'mattress')
      end
      break unless @menu_option.do(menu_type: 'mattress', option_number: @user_input.last_input)
    end
    @console_print.clear_console
  end

  def pocket_menu
    @console_print.clear_console
    loop do
      loop do
        @menus_ui.show_pocket_menu
        break if @user_input.validate_menu_input(menu_type: 'pocket')
      end
      break unless @menu_option.do(menu_type: 'pocket', option_number: @user_input.last_input)
    end
    @console_print.clear_console
  end

  def goal_menu
    @console_print.clear_console
    loop do
      loop do
        @menus_ui.show_goal_menu
        break if @user_input.validate_menu_input(menu_type: 'goal')
      end
      break unless @menu_option.do(menu_type: 'goal', option_number: @user_input.last_input)
    end
    @console_print.clear_console
  end
end
