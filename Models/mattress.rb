# mattress model class
class Mattress
  @save_money
  @id
  @user_id
  @mysql_obj
  attr_accessor :save_money, :id

  def initialize(mysql_obj, user_id)
    @user_id = user_id
    @mysql_obj = mysql_obj
    result = @mysql_obj.query("SELECT * FROM `mattresses` WHERE `user_id` = '#{@user_id}'")
    result.each do |row|
      @id = row['id']
      @save_money = row['save_money']
    end
  end

  def deposit(amount)
    account_id = return_element(@mysql_obj.query("SELECT id FROM accounts WHERE user_id = '#{@user_id}'"), 'id')
    @mysql_obj.query('BEGIN')
    @mysql_obj.query("UPDATE `accounts` SET `available` = available - '#{amount}' WHERE id = '#{account_id}'")
    @mysql_obj.query("UPDATE `mattresses` SET `save_money` = '#{@save_money + amount}' WHERE `mattresses`.`id` = '#{@id}'")
    @mysql_obj.query("INSERT INTO `internal_transactions` (`type`, `user_id`, `amount`) VALUES ('deposit',#{@user_id},#{amount})")
    if account.available - amount >= 0
      @save_money += amount
      @mysql_obj.query('COMMIT')
      true
    else
      @mysql_obj.query('ROLLBACK')
      return false
    end
  end

  def withdraw(amount)
    account_id = return_element(@mysql_obj.query("SELECT id FROM accounts WHERE user_id = '#{@user_id}'"), 'id')
    @mysql_obj.query('BEGIN')
    @mysql_obj.query("UPDATE `mattresses` SET `save_money` = #{@save_money - amount} WHERE id = #{@id}")
    @mysql_obj.query("UPDATE `accounts` SET `available` = available + '#{amount}'  WHERE id = '#{account_id}'")
    @mysql_obj.query("INSERT INTO `internal_transactions` (`type`, `user_id`, `amount`) VALUES ('withdraw',#{@user_id},#{amount})")
    
    if @save_money - amount >= 0
      @save_money -= amount
      @mysql_obj.query('COMMIT')
      return true
    else
      @mysql_obj.query('ROLLBACK')
      return false
    end
  end

  private

  def return_element(element, name)
    element.each do |i|
      return i[name]
    end
  end
end
