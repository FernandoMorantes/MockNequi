if ['mingw32', 'mingw64'].include?(Gem::Platform.local.os)
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
  rescue StandardError => e
    if e.error_number == 1049
      @mysql_obj = Mysql2::Client.new(
        username: ENV['user_name'],
        password: ENV['password'],
        host: ENV['host'],
        port: ENV['port'],
        socket: ENV['socket']
      )
      @mysql_obj.query("CREATE DATABASE IF NOT EXISTS `#{ENV['db_name']}` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci")
      @mysql_obj = Mysql2::Client.new(
        username: ENV['user_name'],
        password: ENV['password'],
        host: ENV['host'],
        port: ENV['port'],
        database: ENV['db_name'],
        socket: ENV['socket']
      )
      require_relative 'create_database'
    end
  end

  def query(query)
    @mysql_obj.query(query, cast_booleans: true)
  end

  def close_connection
    @mysql_obj.close
  end
end
