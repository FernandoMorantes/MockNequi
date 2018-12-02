# class that controls the sessions of the application
class Session
  @current_logged_user
  attr_accessor :current_logged_user

  def initialize(mysql_obj)
    @session_active = false
    @mysql_obj = mysql_obj
    @user_input = UserInput.new
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
    register_user(name, last_name, email, password)
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
    if login(email, password)
      puts("\nBienvenido #{@current_logged_user.first_name}")
      return true
    else
      puts("\nEmail o contraseña incorrectos. Intentalo nuevamente")
      return false
    end
  end

  private

  def register_user(first_name, last_name, email, password)
    password = Digest::SHA2.hexdigest(password)
    result = @mysql_obj.query("INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`) VALUES ('#{first_name}', '#{last_name}', '#{email}', '#{password}')")
    id = return_element(@mysql_obj.query("SELECT `id` FROM `users` WHERE `email` = '#{email}'"), 'id')
    @mysql_obj.query("INSERT INTO `accounts` (`available`, `user_id`) VALUES ('0', '#{id}')")
    @mysql_obj.query("INSERT INTO `mattresses` (`user_id`, `save_money`) VALUES ('#{id}', '0')")
  end

  def login(email, password)
    password = Digest::SHA2.hexdigest(password)
    id = return_element(@mysql_obj.query("SELECT `id` FROM `users` WHERE `email` = '#{email}'"), 'id')
    password_database = return_element(@mysql_obj.query("SELECT `password` FROM `users` WHERE `id` = '#{id}'"), 'password')

    if password_database != password
      return false
    else
      @current_logged_user = User.new(@mysql_obj, id)
      return true
    end
  end

  def return_element(element, name)
    element.each do |i|
      return i[name]
    end
  end
end
