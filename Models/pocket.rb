# pocket model class
class Pocket
  @id
  @balance
  @name
  @mysql_obj
  @user_id

  attr_accessor :name, :balance, :active

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

  def delete
    balance = @balance
    withdraw(@balance)
    @mysql_obj.query("UPDATE `pockets` SET `active` = '0' WHERE `pockets`.`id` = '#{@id}'")
    @active = '0'
    balance
  end

  def transfer_money(email, amount)
    id_destination = return_element(@mysql_obj.query("SELECT `id` FROM `users` WHERE `email` = '#{email}'"), 'id')

    unless id_destination.is_a?(Array)
      @mysql_obj.query('BEGIN')
      @mysql_obj.query("UPDATE pockets SET balance = balance - '#{amount}' WHERE id = '#{@id}'")
      @mysql_obj.query("UPDATE accounts SET available = available + '#{amount}' WHERE user_id = '#{id_destination}'")
      @mysql_obj.query("INSERT INTO `transfers` (`user_id_origin`, `user_id_destination`, `amount`) VALUES ('#{@user_id}', '#{id_destination}', '#{amount}')")
    end
    if (@balance - amount) < 0
      @mysql_obj.query('ROLLBACK')
      return false
    else
      @balance -= amount
      @mysql_obj.query('COMMIT')
      return true
    end
  end

  def deposit(amount, available)
    account_id = return_element(@mysql_obj.query("SELECT id FROM accounts WHERE user_id = '#{@user_id}'"), 'id')
    @mysql_obj.query('BEGIN')
    @mysql_obj.query("UPDATE `accounts` SET `available` = available - '#{amount}'  WHERE id = '#{account_id}'")
    @mysql_obj.query("UPDATE `pockets` SET `balance` = '#{@balance + amount}' WHERE `pockets`.`id` = '#{@id}'")
    @mysql_obj.query("INSERT INTO `internal_transactions` (`type`, `user_id`, `amount`) VALUES ('deposit',#{@user_id},#{amount})")

    if available - amount >= 0
      @balance += amount
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
    " \n
    nombre: #{@name}
    saldo: #{format_money(@balance)} \n"
  end

  private

  def return_element(element, name)
    element.each do |i|
      return i[name]
    end
  end

  def format_money(money)
    money_format = ''
    count = 0
    money.to_s.split('').reverse.each do |number|
      if count == 3
        money_format += '.'
        count = 0
      end
      money_format += number.to_s
      count += 1
    end
    "\e[1;32m$#{money_format.reverse}\e[m"
  end
end
