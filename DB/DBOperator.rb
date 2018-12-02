if Gem::Platform.local.os == 'windows'
  require_relative '../config/config_database_windows'
elsif Gem::Platform.local.os == 'linux'
  require_relative '../config/config_database_linux'
end

# class that controls the connection and queries the database
class DBOperator
  def initialize
    @mysql_obj = Mysql2::Client.new(
      username: ENV['user_name'],
      password: ENV['password'],
      host: ENV['host'],
      port: ENV['port'],
      database: ENV['db_name'],
      socket: ENV['socket']
    )
  end

  def query(query)
    @mysql_obj.query(query, cast_booleans: true)
  end

  def close_connection
    @mysql_obj.close
  end
end
