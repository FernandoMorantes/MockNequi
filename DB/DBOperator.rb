require_relative 'config_windows'

class DBOperator
  @mysql_obj
  def initialize
    @mysql_obj = Mysql2::Client.new(
      host: $host,
   	  username: $user_name,
    	port: $port,
    	database: $db_name,
      socket: $socket,
      password: $password)
      puts 'creado'
  end

  def query(query)
    @mysql_obj.query(query)
  end
end
