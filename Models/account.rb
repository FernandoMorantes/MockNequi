# user model class

class Account
  @id
  @available
  @user_id
  @mysql_obj

  attr_accessor :available, :id

  def initialize(mysql_obj, user_id)
    @mysql_obj = mysql_obj
    @user_id = user_id
    result = @mysql_obj.query("SELECT * FROM `accounts` WHERE `user_id` = #{@user_id}")
    result.each do |row|
      @id = row['id']
      @available = row['available']
    end
  end

  def transfer_money(email, amount)
    id_destination = return_element(@mysql_obj.query("SELECT `id` FROM `users` WHERE `email` = '#{email}'"), 'id')
    
    if !id_destination.kind_of?(Array)
      @mysql_obj.query('BEGIN')
      @mysql_obj.query("UPDATE accounts SET available = available - '#{amount}' WHERE user_id = '#{@user_id}'")
      @mysql_obj.query("UPDATE accounts SET available = available + '#{amount}' WHERE user_id = '#{id_destination}'")
      @mysql_obj.query("INSERT INTO `transfers` (`user_id_origin`, `user_id_destination`, `amount`) VALUES ('#{@user_id}', '#{id_destination}', '#{amount}')")
    else
      return false
    end

    if (@available - amount) < 0
      @mysql_obj.query('ROLLBACK')
      return false
    else
      @available -= amount
      @mysql_obj.query('COMMIT')
      return true
    end
  end

  def deposit(amount)
    @available += amount
    @mysql_obj.query("UPDATE `accounts` SET `available` = #{@available} WHERE id = #{@id}")
    @mysql_obj.query("INSERT INTO `external_trasactions`(`type`, `user_id`, `amount`) VALUES ('deposit',#{@user_id},#{amount})")
  end

  def withdraw(amount)
    @mysql_obj.query('BEGIN')
    @mysql_obj.query("UPDATE `accounts` SET `available` = #{@available - amount} WHERE id = #{@id}")
    @mysql_obj.query("INSERT INTO `external_trasactions`(`type`, `user_id`, `amount`) VALUES ('withdraw',#{@user_id},#{amount})")
    if @available - amount >= 0
      @available -= amount
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
