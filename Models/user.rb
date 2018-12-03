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

  def total_balance
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
    list = []
    count = 0
    transactions = @mysql_obj.query("(SELECT ext.type,ext.amount,ext.transaction_date
                                    FROM `external_trasactions` AS ext
                                    INNER JOIN users ON ext.user_id = users.id WHERE users.id = '#{@id}'
                                    ORDER BY ext.transaction_date DESC)
                                    UNION (SELECT CONCAT(IF(user_id_origin = '#{@id}','sending','reception')) as type, tx.amount,tx.transaction_date
                                    FROM `transfers` AS tx INNER JOIN users ON tx.user_id_destination = users.id OR tx.user_id_origin = users.id
                                    WHERE users.id = '#{@id}'
                                    ORDER BY tx.transaction_date DESC)
                                    ORDER BY `transaction_date` DESC")
    transactions.each_with_index do |row, index|
      list.push(row)
      break if index >= (n_transactions-1)
    end
    list
  end

  def add_pocket(name)
    if search_pocket(name).nil?
      @mysql_obj.query("INSERT INTO `pockets` (`name`, `balance`, `active`, `user_id`) VALUES ('#{name}', '0', '1', '#{@id}')")
      @pockets = []
      define_pockets
      true
    else
      false
    end
  end

  def search_pocket(name)
    @pockets.each do |pocket|
      return pocket if pocket.name == name && pocket.active == true
    end
    nil
  end

  def add_goal(name, expected_amount, year, month, day)
    if search_goal(name).nil? && DateTime.new(year, month, day) > DateTime.now
      expiration_date = DateTime.new(year, month, day).strftime('%Y-%m-%d %H:%M:%S')
      return false unless search_goal(name).nil?
      @mysql_obj.query("INSERT INTO `goals` (`name`, `current_amount`, `expected_amount`, `active`, `status`, `user_id`, `expiration_date`) VALUES ('#{name}', '0', '#{expected_amount}', '1', 'in progress', '#{@id}', '#{expiration_date}')")
      @goals = []
      define_goals
      true
    else
      false
    end
  end

  def list_pockets
    define_pockets
    list = "\nLista de bolsillos:"
    pockets.each do |pocket|
      list += pocket.to_string if pocket.active == true
    end
    list
  end

  def list_goals
    define_goals
    list = "\nLista de metas activas:\n"
    goals.each do |goal|
      list += goal.to_string if goal.active == true && goal.status != 'fulfilled'
    end
    list += "\nLista de metas cumplidas:\n"
    goals.each do |goal|
      if goal.status == 'fulfilled'
        list += goal.to_string
      end
    end
    list
  end

  def search_goal(name)
    @goals.each do |goal|
      return goal if goal.name == name && goal.active
    end
    nil
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
    @pockets =[]
    pockets = @mysql_obj.query("SELECT * FROM `pockets` WHERE `user_id` = #{@id} AND `active` = '1'")
    pockets.each do |pocket|
      @pockets.push(Pocket.new(@mysql_obj, pocket['id']))
    end
  end

  def define_goals
    @goals =[]
    goals = @mysql_obj.query("SELECT * FROM `goals` WHERE `user_id` = #{@id} AND `active` = '1'")
    goals.each do |goal|
      @goals.push(Goal.new(@mysql_obj, goal['id']))
    end
  end
end
