class GoalController
  def initialize(user:)
    @user_input = UserInput.new
    @user = user
    @form = GoalForm.new
  end

  def list
    puts @user.list_goals
  end

  def deposit
    data = nil
    loop do
      data = @form.form_deposit
      break unless @user.search_goal(data[:name]).nil?
      puts "\nLa meta #{data[:name]} no existe"
    end
    if @user.search_goal(data[:name]).deposit(data[:amount], @user.account.available)
      @user.account.available -= data[:amount]
      puts "\nDinero agregado a la meta #{data[:name]} con exito!"
    else
      puts "\nLa cantidad a depositar no esta disponible en su cuenta"
    end
  end

  def create
    data = @form.form_create
    @user.add_goal(data[:name], data[:expected_amount], data[:year], data[:month], data[:day])
    puts "\nLa meta #{data[:name]} ha sido creado con exito!"
  end

  def delete
    name = nil
    loop do
      name = @form.form_delete
      break unless @user.search_goal(name).nil?
      puts "\nLa meta #{name} no existe"
    end
    @user.search_goal(name).delete(@user.account)
    puts "La meta #{name} ha sido cerrada con exito, el dinero esta disponible en la cuenta"
  end
end
