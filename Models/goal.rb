# goal model class
class Goal
  @id
  @name
  @expiration_date
  @current_amount
  @expected_amount
  @expired
  def initialize; end

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
