# class that controls the sessions of the application
class Session
  def initialize(mysql_obj)
    @session_active = false
    @mysql_obj = mysql_obj
  end
  def register_user
    
  end
  def login; end
end