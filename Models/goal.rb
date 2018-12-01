# goal model class
class Goal
  @id
  @name
  @expiration_date
  @current_amount
  @expected_amount
  @status
  @active
  @mysql_obj
  @user_id

  attr_accessor :name, :current_amount, :status, :active, :expected_amount
  def initialize(mysql_obj, id)
    @id = id
    @mysql_obj = mysql_obj
    result = @mysql_obj.query("SELECT * FROM `goals` WHERE `id` = #{@id}")
    result.each do |goal|
      @active = goal['active']
      @name = goal['name']
      @expiration_date = goal['expiration_date']
      @current_amount = goal['current_amount']
      @expected_amount = goal['expected_amount']
      @status = goal['status']
      @user_id = goal['user_id']
    end
  end

  def withdraw(amount, account)
    account_id = return_element(@mysql_obj.query("SELECT id FROM accounts WHERE user_id = '#{@user_id}'"), 'id')
    @mysql_obj.query('BEGIN')
    @mysql_obj.query("UPDATE `goals` SET `current_amount` = #{@current_amount - amount} WHERE id = #{@id}")
    @mysql_obj.query("UPDATE `accounts` SET `available` = available + '#{amount}'  WHERE id = '#{account_id}'")
    @mysql_obj.query("INSERT INTO `internal_transactions` (`type`, `user_id`, `amount`) VALUES ('withdraw',#{@user_id},#{amount})")
    if @current_amount - amount >= 0
      @current_amount -= amount
      account.available += amount
      @mysql_obj.query('COMMIT')
      return true
    else
      @mysql_obj.query('ROLLBACK')
      return false
    end
  end

  def deposit(amount)
    account_id = return_element(@mysql_obj.query("SELECT id FROM accounts WHERE user_id = '#{@user_id}'"), 'id')
    @mysql_obj.query('BEGIN')
    @mysql_obj.query("UPDATE `accounts` SET `available` = available - '#{amount}' WHERE id = '#{account_id}'")
    @mysql_obj.query("UPDATE `goals` SET `current_amount` = '#{@current_amount + amount}' WHERE `goals`.`id` = '#{@id}'")
    @mysql_obj.query("INSERT INTO `internal_transactions` (`type`, `user_id`, `amount`) VALUES ('deposit',#{@user_id},#{amount})")

    if account.available - amount >= 0
      @current_amount += amount
      @mysql_obj.query('COMMIT')
      true
    else
      @mysql_obj.query('ROLLBACK')
      return false
    end
  end

  def to_string
    "
    nombre: #{@name}
    monto total: #{@expected_amount}
    dinero ahorrado: #{@current_amount}
    dinero restante: #{remaining_money}
    estado: #{@status}
    facha limite: #{@expiration_date} \n\n"
  end

  def delete(account)
    withdraw(@current_amount, account)
    @mysql_obj.query("UPDATE `goals` SET `active` = '0' WHERE `goals`.`id` = '#{@id}'")
    @active = '0'
  end

  private

  def return_element(element, name)
    element.each do |i|
      return i[name]
    end
  end

  def remaining_money
    @expected_amount - @current_amount
  end
end
