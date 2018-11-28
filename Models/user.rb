# user model class
class User
  @id
  @first_name
  @last_name
  @email
  @password
  @mattress
  @account
  @mysql_obj

  attr_accessor :id, :password, :mattress, :pockets, :goals, :first_name, :last_name, :email, :account
  def initialize(mysql_obj, id)
    @pockets = []
    @goals = []
    @id = id
    @mysql_obj = mysql_obj
    define_attributes
    @mattress = Mattress.new(@mysql_obj, @id)
    @account = Account.new(@mysql_obj, @id)
    define_pockets
    define_goals
  end

  def available
    @account.available
  end

  def balance_total
    sum_total = @account.available + @mattress.save_money
    @pockets.each do |pocket|
      sum_total += pocket.balance
    end
    @goals.each do |goal|
      sum_total += goal.current_amount
    end
    sum_total
  end

  def list_transactions(n_transactions)
    count = 0
    transactions = @mysql_obj.query("(SELECT ext.type,ext.amount,ext.transaction_date FROM `external_trasactions` AS ext INNER JOIN users ON ext.user_id = users.id WHERE users.id = '#{@id}' ORDER BY ext.transaction_date DESC) UNION (SELECT CONCAT(IF(user_id_origin = '#{@id}','send','reception')) as type, tx.amount,tx.transaction_date FROM `transfers` AS tx INNER JOIN users ON tx.user_id_destination = users.id OR tx.user_id_origin = users.id WHERE users.id = '#{@id}' ORDER BY tx.transaction_date DESC) ORDER BY `transaction_date` DESC")
    transactions.each do |row|
      puts row
      count += 1
      break if count >= n_transactions
    end
    gets
  end

  def transfer_money(email, amount)
    @account.transfer_money(email, amount)
  end

  def add_pocket(name)
    @mysql_obj.query("INSERT INTO `pockets` (`name`, `balance`, `active`, `user_id`) VALUES ('#{name}', '0', '1', '#{@id}')")
    @pockets = []
    define_pockets
    true
  end

  def add_goal(name, expected_amount, year, month, day)
    expiration_date = DateTime.new(year, month, day).strftime('%Y-%m-%d %H:%M:%S')
    @mysql_obj.query("INSERT INTO `goals` (`name`, `current_amount`, `expected_amount`, `active`, `status`, `user_id`, `expiration_date`) VALUES ('#{name}', '0', '#{expected_amount}', '1', 'in progress', '#{@id}', '#{expiration_date}')")
    @goals = []
    define_goals
    true
  end

  private

  def define_attributes
    result = @mysql_obj.query("SELECT * FROM `users` WHERE `id` = #{@id}")
    result.each do |row|
      @first_name = row['first_name']
      @last_name = row['last_name']
      @email = row['email']
      @password = row['password']
    end
  end

  def define_pockets
    pockets = @mysql_obj.query("SELECT * FROM `pockets` WHERE `user_id` = #{@id}")
    pockets.each do |pocket|
      @pockets.push(Pocket.new(@mysql_obj, pocket['id']))
    end
  end

  def define_goals
    goals = @mysql_obj.query("SELECT * FROM `goals` WHERE `user_id` = #{@id}")
    goals.each do |goal|
      @goals.push(Goal.new(@mysql_obj, goal['id']))
    end
  end
end
