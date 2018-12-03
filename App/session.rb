# class that controls the sessions of the application
class Session
  @current_logged_user
  attr_accessor :current_logged_user

  def initialize(mysql_obj)
    @session_active = false
    @mysql_obj = mysql_obj
    @user_input = UserInput.new
    @console_print = ConsolePrint.new
  end

  def registration_process
    @console_print.title title:"Resgistro \n"
    loop do
      @console_print.credentials_field field:"\nnombre: "
      break if @user_input.validate_user_data_input(field: 'name')
    end
    name = @user_input.last_input
    loop do
      @console_print.credentials_field field:"\napellido: "
      break if @user_input.validate_user_data_input(field: 'last name')
    end
    last_name = @user_input.last_input
    loop do
      @console_print.credentials_field field:"\nemail: "
      break if @user_input.validate_user_data_input(field: 'email')
    end
    email = @user_input.last_input
    loop do
      @console_print.credentials_field field:"\ncontraseña: "
      break if @user_input.validate_user_data_input(field: 'password')
    end
    password = @user_input.last_input
    register_user(name, last_name, email, password)
    @console_print.success_message message:"\nEl registro ha sido exitoso!"
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def login_process
    @console_print.title title:"Iniciar Sesion \n"
    loop do
      @console_print.credentials_field field:"\nemail: "
      break if @user_input.validate_user_data_input(field: 'email')
    end
    email = @user_input.last_input
    loop do
      @console_print.credentials_field field:"\ncontraseña: "
      break if @user_input.validate_user_data_input(field: 'password')
    end
    password = @user_input.last_input
    if login(email, password)
       @console_print.clear_console
       @console_print.welcome_message message:"\nBienvenido #{@current_logged_user.first_name} \n"
      return true
    else
      @console_print.error error:"\nError: Email o contraseña incorrectos. Intentalo nuevamente"
      return false
    end
  end

  private

  def register_user(first_name, last_name, email, password)
    password = Digest::SHA2.hexdigest(password)
    @mysql_obj.query("INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`)
                      VALUES ('#{first_name}', '#{last_name}', '#{email}', '#{password}')")
    id = return_element(@mysql_obj.query("SELECT `id` FROM `users` 
                                          WHERE `email` = '#{email}'"), 'id')
    @mysql_obj.query("INSERT INTO `accounts` (`available`, `user_id`)
                      VALUES ('0', '#{id}')")
    @mysql_obj.query("INSERT INTO `mattresses` (`user_id`, `save_money`)
                      VALUES ('#{id}', '0')")
  end

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
