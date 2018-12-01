# runner class
class MockNequi
  def initialize
    @mysql_obj = DBOperator.new
    @session = Session.new(@mysql_obj)
    @menus_ui = MenusUI.new
    @user_input = UserInput.new
  end

  def run
    puts "\nBienvenido a Mock Nequi \n"
    loop do
      begin
        @menus_ui.show_main_menu
      end until @user_input.validate_menu_input(menu_type: 'main')
      case @user_input.last_input.to_i
      when 1
        @session.registration_process
      when 2
        if @session.login_process
          user_menu = UserMenu.new(user: @session.current_logged_user, session: @session)
          user_menu.show
        end
      when 3
        puts 'Hasta luego'
        @mysql_obj.close_connection
        exit
      end
    end
  end
end
