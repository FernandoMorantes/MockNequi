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

    begin
      begin
        @menusUI.show_main_menu
        @user_input.read_console_input
        puts "\nLa opcion ingresada esta mal escrita o no es valida" unless @user_input.validate_menu_input(menu_type: 'main')
      end while !@user_input.validate_menu_input(menu_type: 'main')

      if @user_input.menu_input.option == 'registrarse'

        registration_process

      elsif @user_input.menu_input.option == 'ingresar'

        if login_process
          user_menu = UserMenu.new(user: @session.current_logged_user, session: @session, user_input: @user_input, menusUI: @menusUI)
          user_menu.show
        end

      elsif @user_input.menu_input.option == 'cerrar el programa'
        puts 'Hasta luego'
        @mysql_obj.close_connection
      end
    end while @user_input.menu_input.option != 'cerrar el programa'
  end

  def registration_process
    begin
      print "\nnombre: "
      @user_input.read_console_input
      if @user_input.validate_user_data_input(field: 'name')
        name = @user_input.last_input
      else
        puts 'el dato ingresado no es valido. Minimo 2 caracteres, maximo 60'
      end
    end while !@user_input.validate_user_data_input(field: 'name')

    begin
      print "\napellido: "
      @user_input.read_console_input
      if @user_input.validate_user_data_input(field: 'last name')
        last_name = @user_input.last_input
      else
        puts 'el dato ingresado no es valido. Minimo 2 caracteres, maximo 60'
      end
    end while !@user_input.validate_user_data_input(field: 'last name')

    begin
      print "\nemail: "
      @user_input.read_console_input
      if @user_input.validate_user_data_input(field: 'email')
        email = @user_input.last_input
      else
        puts 'el email ingresado no es valido'
      end
    end while !@user_input.validate_user_data_input(field: 'email')

    begin
      print "\ncontraseña: "
      @user_input.read_console_input
      if @user_input.validate_user_data_input(field: 'password')
        password = @user_input.last_input
      else
        puts 'la contraseña ingresada no es valida. Minimo 5 caracteres, maximo 60'
      end
    end while !@user_input.validate_user_data_input(field: 'password')

    @session.register_user(name, last_name, email, password)

    puts 'El registro ha sido exitoso!'
  end

  def login_process
    begin
      print "\nemail: "
      @user_input.read_console_input
      if @user_input.validate_user_data_input(field: 'email')
        email = @user_input.last_input
      else
        puts 'el email ingresado no es valido'
      end
    end while !@user_input.validate_user_data_input(field: 'email')

    begin
      print "\ncontraseña: "
      @user_input.read_console_input
      if @user_input.validate_user_data_input(field: 'password')
        password = @user_input.last_input
      else
        puts 'la contraseña ingresada no es valida.'
      end
    end while !@user_input.validate_user_data_input(field: 'password')

    if @session.login(email, password)
      puts("\nBienvenido #{@session.current_logged_user.first_name}")
      return true
    else
      puts("\nEmail o contraseña incorrectos. Intentalo nuevamente")
      return false
    end
  end
end
