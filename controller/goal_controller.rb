class GoalController < ConsolePrint
  def initialize(user:)
    @user_input = UserInput.new
    @user = user
    @form = GoalForm.new
  end

  def list
    print_blue @user.list_goals
    wait_for_enter
    clear_console
  end

  def deposit
    data = nil
    loop do
      data = @form.form_deposit
      break unless @user.search_goal(data[:name]).nil?
      print_red_bold "\nLa meta #{data[:name]} no existe"
    end
    if @user.search_goal(data[:name]).deposit(data[:amount], @user.account.available)
      @user.account.available -= data[:amount]
      print_green_bold "\nDinero agregado a la meta #{data[:name]} con exito!"
    else
      print_red_bold "\nLa cantidad a depositar no esta disponible en su cuenta"
    end
    wait_for_enter
    clear_console
  end

  def create
    data = @form.form_create
    @user.add_goal(data[:name], data[:expected_amount], data[:year], data[:month], data[:day])
    print_green_bold "\nLa meta #{data[:name]} ha sido creado con exito!"
    wait_for_enter
    clear_console
  end

  def delete
    name = nil
    loop do
      name = @form.form_delete
      break unless @user.search_goal(name).nil?
      print_red_bold "\nLa meta #{name} no existe"
    end
    @user.search_goal(name).delete(@user.account)
    print_green_bold "La meta #{name} ha sido cerrada con exito, el dinero esta disponible en la cuenta"
    wait_for_enter
    clear_console
  end
end
