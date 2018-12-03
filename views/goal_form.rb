class GoalForm
  def initialize
    @user_input = UserInput.new
    @console_print= ConsolePrint.new
  end

  def form_deposit
    loop do
      @console_print.blue_message message:"\nNombre de la meta: "
      break if @user_input.validate_user_data_input(field: 'name')
    end
    name = @user_input.last_input
    loop do
      @console_print.blue_message message:'ingrese la cantidad de dinero que desea agregar a la meta: '
      break if @user_input.validate_amount_input
    end
    amount = @user_input.last_input.to_i
    { name: name, amount: amount }
  end

  def form_create
    loop do
      @console_print.blue_message message:"\nNombre de la meta: "
      break if @user_input.validate_user_data_input(field: 'name')
    end
    name = @user_input.last_input
    loop do
      @console_print.blue_message message:'Monto total de la meta: '
      break if @user_input.validate_amount_input
    end
    expected_amount = @user_input.last_input.to_i
    puts 'Por favor ingrese el año, el mes y el dia de vencimiento de la meta en numeros'
    loop do
      @console_print.blue_message message:'Ingrese el plazo maximo de la meta (año): '
      break if @user_input.validate_date_input(type: 'year')
    end
    year = @user_input.last_input.to_i
    loop do
      @console_print.blue_message message:'Ingrese el plazo maximo de la meta (mes): '
      break if @user_input.validate_date_input(type: 'month')
    end
    month = @user_input.last_input.to_i
    loop do
      @console_print.blue_message message:'Ingrese el plazo maximo de la meta (dia): '
      break if @user_input.validate_date_input(type: 'day', month:month)
    end
    day = @user_input.last_input.to_i
    { name: name, expected_amount: expected_amount, year: year, month: month, day: day }
  end

  def form_delete
    loop do
      @console_print.blue_message message:'Nombre de la meta a cerrar: '
      break if @user_input.validate_user_data_input(field: 'name')
    end
    @user_input.last_input
  end
end
