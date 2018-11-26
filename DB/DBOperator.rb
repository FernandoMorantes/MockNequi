require_relative '../config/config_windows'

# class that controls the connection and queries the database
class DBOperator

  def initialize
    @mysql_obj = Mysql2::Client.new(
      host: $host,
      username: $user_name,
      port: $port,
      database: $db_name,
      socket: $socket,
      password: $password
    )
  end

  def query(query)
    @mysql_obj.query(query)
  end
end
