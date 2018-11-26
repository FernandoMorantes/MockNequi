# user model class

class Account
  @id
  @balance
  @user_id
  @mysql_obj
  attr_accessor :balance, :id

  def initialize; end

  def transfer_money(email); end

  def deposit(amount)
    @mysql_obj.query("UPDATE `accounts` SET `avaliable` = #{@balance + amount} WHERE id = #{@id}")
    @mysql_obj.query("INSERT INTO `external_trasactions`(`type`, `user_id`, `amount`) VALUES ('deposit',#{@user_id},#{amount})")
  end

  def withdraw(amount)
    @mysql_obj.query("UPDATE `accounts` SET `avaliable` = #{@balance - amount} WHERE id = #{@id}")
    @mysql_obj.query("INSERT INTO `external_trasactions`(`type`, `user_id`, `amount`) VALUES ('withdraw',#{@user_id},#{amount})")
  end
end
