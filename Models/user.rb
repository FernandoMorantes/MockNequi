# user model class
class User
  @id
  @first_name
  @last_name
  @email
  @password
  @mattress
  @account
  @pockets = []
  @goals = []
  def initialize(mysql_obj) 
  end

  def available
    @account.balance
  end

  def balance_total; end

  def list_transactions(n_transactions); end
end
