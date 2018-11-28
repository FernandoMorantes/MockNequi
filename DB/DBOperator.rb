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
      host: $host,
      username: $user_name,
      port: $port,
      database: $db_name,
      socket: $socket,
      password: $password
    )
  end

  def query(query)
    @mysql_obj.query(query, cast_booleans: true)
  end
  def close
    @mysql_obj.close
  end
end
