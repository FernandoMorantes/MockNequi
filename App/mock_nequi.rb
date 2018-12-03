# runner class
class MockNequi < ConsolePrint
  def initialize
    @mysql_obj = DBOperator.new
    @session = Session.new(@mysql_obj)
    @menus_ui = MenusUI.new
    @user_input = UserInput.new
    @console_print = ConsolePrint.new
  end

  def run
    @console_print.title title:"\nBienvenido a Mock Nequi \n"
    loop do
      loop do
        @menus_ui.show_main_menu
        break if @user_input.validate_menu_input(menu_type: 'main')
      end
      case @user_input.last_input.to_i
      when 1
        clear_console
        @session.registration_process
      when 2
        clear_console
        if @session.login_process
          user_menu = UserMenu.new(user: @session.current_logged_user)
          user_menu.show
        end
      when 3
        @console_print.mock_loading message:'saliendo'
        @mysql_obj.close_connection
        exit
      end
    end
  end
end
