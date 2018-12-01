# runner class
class MockNequi
  def initialize
    @mysql_obj = DBOperator.new
    @session = Session.new(@mysql_obj)
    @menusUI = MenusUI.new
    @user_input = UserInput.new
  end

  def run
    puts "\nBienvenido a Mock Nequi \n"
    loop do
      begin
        @menusUI.show_main_menu
      end until @user_input.validate_menu_input(menu_type: 'main')
      case @user_input.last_input
      when 1
        registration_process
      when 2
        if login_process
          user_menu = UserMenu.new(user: @session.current_logged_user, session: @session, user_input: @user_input, menusUI: @menusUI)
          user_menu.show
        end
      when 3
        puts 'Hasta luego'
        @mysql_obj.close_connection
        exit
      end
    end
  end

  def registration_process
    begin
      print "\nnombre: "
    end until @user_input.validate_user_data_input(field: 'name')
    name = @user_input.last_input
    begin
      print "\napellido: "
    end until @user_input.validate_user_data_input(field: 'last name')
    last_name = @user_input.last_input
    begin
      print "\nemail: "
    end until @user_input.validate_user_data_input(field: 'email')
    email = @user_input.last_input
    begin
      print "\ncontraseña: "
    end until @user_input.validate_user_data_input(field: 'password')
    password = @user_input.last_input
    @session.register_user(name, last_name, email, password)
    puts 'El registro ha sido exitoso!'
  end

  def login_process
    begin
      print "\nemail: "
    end until @user_input.validate_user_data_input(field: 'email')
    email = @user_input.last_input
    begin
      print "\ncontraseña: "
    end until @user_input.validate_user_data_input(field: 'password')
    password = @user_input.last_input
    if @session.login(email, password)
      puts("\nBienvenido #{@session.current_logged_user.first_name}")
      return true
    else
      puts("\nEmail o contraseña incorrectos. Intentalo nuevamente")
      return false
    end
  end
end
