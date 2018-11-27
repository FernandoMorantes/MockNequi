# runner class
class MockNequi
  def initialize
    @mysql_obj = DBOperator.new
    @session = Session.new
  end

  def run
  end
end
