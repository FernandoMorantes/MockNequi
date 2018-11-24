require 'config.rb'

class DBOperator
  def initialize
    Mysql2::Client.new(
      host: host,
      username: user_name,
      port: port,
      database: db_name,
      socket: socket,
      password: password
    )
    end
end
