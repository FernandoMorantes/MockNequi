require_relative '../config/config_SO'
if $SO == 'windows'
  require_relative '../config/config_database_windows'
elsif $SO == 'linux'
  require_relative '../config/config_database_linux'
end

# class that controls the connection and queries the database
class DBOperator

  def initialize
    @mysql_obj = Mysql2::Client.new(   
      username: $user_name,
      password: $password,
      host: $host,
      port: $port,
      database: $db_name,
      socket: $socket
    )
  end

  def query(query)
    @mysql_obj.query(query, cast_booleans: true)
  end

  def close_connection
    @mysql_obj.close
  end
end
