# class that controls the sessions of the application
class Session < ConsolePrint
  @current_logged_user
  attr_accessor :current_logged_user

  def initialize(mysql_obj)
    @mysql_obj = mysql_obj
    @user_input = UserInput.new
  end

  # Request the necessary information to register the user
  def registration_process
    print_cyan_bold "Resgistro \n"
    loop do
      print_green "\nnombre: "
      break if @user_input.validate_user_data_input(field: 'name')
    end
    name = @user_input.last_input
    loop do
      print_green "\napellido: "
      break if @user_input.validate_user_data_input(field: 'last name')
    end
    last_name = @user_input.last_input
    loop do
      print_green "\nemail: "
      break if @user_input.validate_user_data_input(field: 'email')
    end
    email = @user_input.last_input
    loop do
      print_green "\ncontraseña: "
      break if @user_input.validate_user_data_input(field: 'password')
    end
    password = @user_input.last_input
    print_green_bold "\nEl registro ha sido exitoso!" if register_user(name, last_name, email, password)
    wait_for_enter
    clear_console
  end

  # Ask for the information needed to log in
  def login_process
    print_cyan_bold "Iniciar Sesion \n"
    loop do
      print_green "\nemail: "
      break if @user_input.validate_user_data_input(field: 'email')
    end
    email = @user_input.last_input
    loop do
      print_green "\ncontraseña: "
      break if @user_input.validate_user_data_input(field: 'password')
    end
    password = @user_input.last_input
    if login(email, password)
      print_purple "\n\n\nBienvenido #{@current_logged_user.first_name} \n"
      return true
    else
      print_red_bold "\nError: Email o contraseña incorrectos. Intentalo nuevamente"
      return false
    end
  end

  private

  # Register a user in the database
  # @param first_name: name of the user to register
  # @param last_name: last name of the user to register
  # @param email: user's email to register
  # @param password: password of the user to register
  def register_user(first_name, last_name, email, password)
    password = Digest::SHA2.hexdigest(password)
    begin
      @mysql_obj.query("INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`)
                        VALUES ('#{first_name}', '#{last_name}', '#{email}', '#{password}')")
      id = return_element(@mysql_obj.query("SELECT `id` FROM `users`
                                            WHERE `email` = '#{email}'"), 'id')
      @mysql_obj.query("INSERT INTO `accounts` (`available`, `user_id`)
                        VALUES ('0', '#{id}')")
      @mysql_obj.query("INSERT INTO `mattresses` (`user_id`, `save_money`)
                        VALUES ('#{id}', '0')")
    rescue StandardError => e
      if e.error_number == 1062
        print_red_bold "\n\nError: ya existe un usuario con este correo"
        return false
      end
    end
    true
  end

  # a user's session starts
  # @param email: user's email
  # @param password: user's password
  def login(email, password)
    password = Digest::SHA2.hexdigest(password)
    id = return_element(@mysql_obj.query("SELECT `id` FROM `users`
                                          WHERE `email` = '#{email}'"), 'id')
    password_database = return_element(@mysql_obj.query("SELECT `password` FROM `users`
                                          WHERE `id` = '#{id}'"), 'password')
    return false if password_database != password
    @current_logged_user = User.new(@mysql_obj, id)
    true
  end

  def return_element(element, name)
    element.each do |i|
      return i[name]
    end
  end
end
