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
    result = @mysql_obj.query("SELECT * FROM `pockets` WHERE `id` = '#{@id}'")
    result.each do |pocket|
      @balance = pocket['balance']
      @name = pocket['name']
      @active = pocket['active']
      @user_id = pocket['user_id']
    end
  end

  def delete; end

  def transfer_money(email); end

  def deposit(amount)
    account_id = return_element(@mysql_obj.query("SELECT id FROM accounts WHERE user_id = '#{@user_id}'"), 'id')
    @mysql_obj.query('BEGIN')
    @mysql_obj.query("UPDATE `accounts` SET `available` = available - '#{amount}'  WHERE id = '#{account_id}'")
    @mysql_obj.query("UPDATE `pockets` SET `balance` = '#{@balance + amount}' WHERE `pockets`.`id` = '#{@id}'")
    @mysql_obj.query("INSERT INTO `internal_transactions` (`type`, `user_id`, `amount`) VALUES ('deposit',#{@user_id},#{amount})")
    @balance += amount
    @mysql_obj.query('COMMIT')
    true
  end

  def withdraw(amount)
    account_id = return_element(@mysql_obj.query("SELECT id FROM accounts WHERE user_id = '#{@user_id}'"), 'id')
    @mysql_obj.query('BEGIN')
    @mysql_obj.query("UPDATE `pockets` SET `balance` = #{@balance - amount} WHERE id = #{@id}")
    @mysql_obj.query("UPDATE `accounts` SET `available` = available + '#{amount}'  WHERE id = '#{account_id}'")
    @mysql_obj.query("INSERT INTO `internal_transactions` (`type`, `user_id`, `amount`) VALUES ('withdraw',#{@user_id},#{amount})")
    if @balance - amount >= 0
      @balance -= amount
      @mysql_obj.query('COMMIT')
      return true
    else
      @mysql_obj.query('ROLLBACK')
      return false
    end
  end

  def to_string
    "nombre: #{@name} \n
    saldo: #{@balance} \n"
  end

  def return_element(element, name)
    element.each do |i|
      return i[name]
    end
  end
end
