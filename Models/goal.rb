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
      @active = goal['active'] != 0
      @name = goal['name']
      @expiration_date = goal['expiration_date']
      @current_amount = goal['current_amount']
      @expected_amount = goal['expected_amount']
      @status = goal['status']
      @user_id = goal['user_id']
    end
  end

  def withdraw; end

  def deposit; end

  def to_string
    "nombre: #{@name},\n
    monto total: #{@expected_amount} \n
    dinero ahorrado: #{@current_amount} \n
    dinero restante: #{remaining_money} \n
    estado: #{@expired == true ? 'vencida' : 'cumplida'} \n
    facha limite: #{@expiration_date} \n"
  end

  def delete; end

  private

  def remaining_money
    @expected_amount - @current_amount
  end
end
