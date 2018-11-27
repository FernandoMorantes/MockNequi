# class that controls the sessions of the application
class Session
  def initialize(mysql_obj)
    @session_active = false
    @mysql_obj = mysql_obj
  end

  def register_user(first_name, last_name, email, password)
    password = Digest::SHA2.hexdigest(password)
    result = @mysql_obj.query("INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`) VALUES ('#{first_name}', '#{last_name}', '#{email}', '#{password}')")
    id = return_element(@mysql_obj.query("SELECT `id` FROM `users` WHERE `email` = '#{email}'"), 'id')
    @mysql_obj.query("INSERT INTO `accounts` (`avaliable`, `user_id`) VALUES ('0', '#{id}')")
    @mysql_obj.query("INSERT INTO `matresses` (`user_id`, `save_money`) VALUES ('#{id}', '0')")
  end

  def login(email, password)
    password = Digest::SHA2.hexdigest(password)
    id = return_element(@mysql_obj.query("SELECT `id` FROM `users` WHERE `email` = '#{email}'"), 'id')
    password_database = return_element(@mysql_obj.query("SELECT `password` FROM `users` WHERE `id` = '#{id}'"), 'password')
    if password_database != password
      return false
    else
      return User.new(@mysql_obj, id)
    end
  end

  private

  def return_element(element, name)
    element.each do |i|
      return i[name]
    end
  end
end
