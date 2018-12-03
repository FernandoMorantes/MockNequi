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
      update_status
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

  def deposit(amount, available)
    account_id = return_element(@mysql_obj.query("SELECT id FROM accounts WHERE user_id = '#{@user_id}'"), 'id')
    @mysql_obj.query('BEGIN')
    @mysql_obj.query("UPDATE `accounts` SET `available` = available - '#{amount}' WHERE id = '#{account_id}'")
    @mysql_obj.query("UPDATE `goals` SET `current_amount` = '#{@current_amount + amount}' WHERE `goals`.`id` = '#{@id}'")
    @mysql_obj.query("INSERT INTO `internal_transactions` (`type`, `user_id`, `amount`) VALUES ('deposit',#{@user_id},#{amount})")

    if available - amount >= 0 && @status == 'in progress'
      @current_amount += amount
      @mysql_obj.query('COMMIT')
      true
    else
      @mysql_obj.query('ROLLBACK')
      return false
    end
  end

  def to_string
    update_status
    "
    nombre: #{@name}
    monto total: #{format_money(@expected_amount)}
    dinero ahorrado: #{format_money(@current_amount)}
    dinero restante: #{format_money(remaining_money)}
    estado: #{@status == 'in progress' && @active ? 'en progreso' : @status == 'fulfilled' ? 'completada' : @active ? 'expirada' : 'cerrada'}
    facha limite: #{@expiration_date.strftime('%a %d %b %Y')} \n\n"
  end

  def delete
    amount = @current_amount
    withdraw(@current_amount)
    @mysql_obj.query("UPDATE `goals` SET `active` = '0' WHERE `goals`.`id` = '#{@id}'")
    @active = '0'
    amount
  end

  private

  def update_status
    date = Date.parse(@expiration_date.to_s)
    @status = if date.ajd < Date.today.ajd
                remaining_money <= 0 ? 'fulfilled' : 'expired'
              else
                remaining_money <= 0 ? 'fulfilled' : 'in progress'
              end
    @mysql_obj.query("UPDATE `goals` SET `status` = '#{@status}' 
                      WHERE `goals`.`id` = '#{@id}'")
  end

  def return_element(element, name)
    element.each do |i|
      return i[name]
    end
  end

  def remaining_money
    @expected_amount - @current_amount
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
