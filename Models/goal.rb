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

  def withdraw(amount)
    account_id = return_element(@mysql_obj.query("SELECT id FROM accounts WHERE user_id = '#{@user_id}'"), 'id')
    @mysql_obj.query('BEGIN')
    @mysql_obj.query("UPDATE `goals` SET `current_amount` = #{@current_amount - amount} WHERE id = #{@id}")
    @mysql_obj.query("UPDATE `accounts` SET `available` = available + '#{amount}'  WHERE id = '#{account_id}'")
    @mysql_obj.query("INSERT INTO `internal_transactions` (`type`, `user_id`, `amount`) VALUES ('withdraw',#{@user_id},#{amount})")
    if @current_amount - amount >= 0
      @current_amount -= amount
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
    @current_amount += amount
    @mysql_obj.query('COMMIT')
    true
  end

  def to_string
    "nombre: #{@name},\n
    monto total: #{@expected_amount} \n
    dinero ahorrado: #{@current_amount} \n
    dinero restante: #{remaining_money} \n
    estado: #{@status} \n
    facha limite: #{@expiration_date} \n"
  end

  def delete
    withdraw(@current_amount)
    @mysql_obj.query("UPDATE `goals` SET `active` = '0' WHERE `goals`.`id` = '#{@id}'")
    true
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
