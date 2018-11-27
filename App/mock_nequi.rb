# runner class
class MockNequi
  def initialize
    @mysql_obj = DBOperator.new
    @session = Session.new(@mysql_obj)
  end

  def run
    result = @mysql_obj.query("SELECT * FROM `users`")
    result.each do |row|
      
    end
  end
end
