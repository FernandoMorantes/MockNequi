# mattress model class
class Mattress
  @save_money
  @id
  @user_id
  @mysql_obj
  attr_accessor :save_money, :id

  def initialize(mysql_obj, id)
    @mysql_obj = mysql_obj
    result = @mysql_obj.query("SELECT * FROM `matresses` WHERE `user_id` = #{@user_id}")
    result.each do |row|
      @id = row['id']
      @save_money = row['save_money']
    end
  end

  def deposit; end

  def withdraw; end
end
