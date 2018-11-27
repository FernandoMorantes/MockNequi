# pocket model class
class Pocket
  @id
  @balance
  @name
  @active
  def initialize; end

  def delete; end

  def transfer_money(email); end

  def deposit; end

  def withdraw; end

  def to_string
    "nombre: #{@name} \n
    saldo: #{@balance} \n"
  end
end
