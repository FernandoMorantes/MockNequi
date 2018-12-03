class GoalController
  def initialize(user:)
    @user = user
    @form = GoalForm.new
    @console_print = ConsolePrint.new
  end

  def list
    @console_print.message message:@user.list_goals
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def deposit
    data = nil
    loop do
      data = @form.form_deposit
      break unless @user.search_goal(data[:name]).nil?
      @console_print.error error:"\nLa meta #{data[:name]} no existe"
    end
    if @user.search_goal(data[:name]).deposit(data[:amount], @user.account.available)
      @user.account.available -= data[:amount]
      @console_print.success_message message:"\nDinero agregado a la meta #{data[:name]} con exito!"
    elsif @user.search_goal(data[:name]).status == 'fulfilled'
      @console_print.error error:"\nNo se puede agrega dinero a una meta cumplida"
    elsif @user.search_goal(data[:name]).status == 'expired'
      @console_print.error error:"\nNo se puede agrega dinero a una meta vencida"
    else
      @console_print.error error:"\nLa cantidad a depositar no esta disponible en su cuenta"
    end
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def create
    data = @form.form_create
    if @user.add_goal(data[:name], data[:expected_amount], data[:year], data[:month], data[:day])
      @console_print.success_message message:"\nLa meta #{data[:name]} ha sido creado con exito!"
    else
      @console_print.error error:"\n La fecha de expiracion de la meta no es valida\n o ya existe la meta #{data[:name]} y se encuentra activa"
    end
    @console_print.wait_for_enter
    @console_print.clear_console
  end

  def delete
    name = nil
    loop do
      name = @form.form_delete
      break unless @user.search_goal(name).nil?
      @console_print.error error:"\nLa meta #{name} no existe"
    end
    amount = @user.search_goal(name).delete
    @user.account.available += amount
    @console_print.success_message message:"La meta #{name} ha sido cerrada con exito, el dinero esta disponible en la cuenta"
    @console_print.wait_for_enter
    @console_print.clear_console
  end
end
