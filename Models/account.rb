# user model class

class Account
  @id
  @balance
  @user_id
  @mysql_obj
  
  attr_accessor :balance, :id

  def initialize(mysql_obj, user_id)
    @mysql_obj = mysql_obj
    @user_id = user_id
    result = @mysql_obj.query("SELECT * FROM `accounts` WHERE `user_id` = #{@user_id}")
    result.each do |row|
      @id = row['id']
      @balance = row['balance']
    end
  end

  def transfer_money(email); end

  def deposit(amount)
    @balance += amount
    @mysql_obj.query("UPDATE `accounts` SET `avaliable` = #{@balance} WHERE id = #{@id}")
    @mysql_obj.query("INSERT INTO `external_trasactions`(`type`, `user_id`, `amount`) VALUES ('deposit',#{@user_id},#{amount})")
  end

  def withdraw(amount)
    if @balance - amount > 0
      @balance -= amount
      @mysql_obj.query("UPDATE `accounts` SET `avaliable` = #{@balance} WHERE id = #{@id}")
      @mysql_obj.query("INSERT INTO `external_trasactions`(`type`, `user_id`, `amount`) VALUES ('withdraw',#{@user_id},#{amount})")
    end
  end
end
