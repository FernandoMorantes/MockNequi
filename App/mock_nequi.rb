# runner class
class MockNequi
  def initialize
    @mysql_obj = DBOperator.new
    @session = Session.new(@mysql_obj)
  end

  def run
    
  end
end
