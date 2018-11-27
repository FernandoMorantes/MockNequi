# pocket model class
class Pocket
  @id
  @balance
  @name
  @mysql_obj
  @user_id
  def initialize(mysql_obj, id)
    @mysql_obj = mysql_obj
    @id = id
    result = @mysql_obj.query("SELECT * FROM `pockets` WHERE `id` = #{@id}")
    result.each do |pocket|
      @balance = pocket['balance']
      @name = pocket['name']
      @active = pocket['active'] != 0
      @user_id = pocket['user_id']
    end
  end

  def delete; end

  def transfer_money(email); end

  def deposit; end

  def withdraw; end

  def to_string
    "nombre: #{@name} \n
    saldo: #{@balance} \n"
  end
end
