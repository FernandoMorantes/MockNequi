class GoalController

    def initialize(user:)
      @user_input = UserInput.new
      @user = user
    end

  def deposit
    begin
      print 'Nombre de la meta: '
    end while !@user_input.validate_user_data_input(field: 'name')
    name = @user_input.last_input
    if !@user.search_goal(name).nil?
      begin
        print 'ingrese la cantidad de dinero que desea agregar a la meta: '
      end while !@user_input.validate_amount_input
      amount = @user_input.last_input.to_i
      if @user.search_goal(name).deposit(amount, @user.account.available)
        @user.account.available -= amount
        puts "\nDinero agregado a la meta #{name} con exito!"
      else
        puts "\nLa cantidad a depositar no esta disponible en su cuenta"
      end
    else
      puts "\nLa meta #{name} no existe"
    end
  end

  def create
    begin
      print 'Nombre de la meta: '
    end while !@user_input.validate_user_data_input(field: 'name')
    name = @user_input.last_input
    begin
      print 'Ingrese la meta de dinero: '
    end while !@user_input.validate_amount_input
    expected_amount = @user_input.last_input

    puts 'Por favor ingrese el año, el mes y el dia de vencimiento de la meta en numeros'
    begin
      print 'Ingrese el plazo maximo de la meta (año): '
    end while !@user_input.validate_date_input(type: 'year')
    year = @user_input.last_input.to_i
    begin
      print 'Ingrese el plazo maximo de la meta (mes): '
    end while !@user_input.validate_date_input(type: 'month')
    month = @user_input.last_input.to_i
    begin
      print 'Ingrese el plazo maximo de la meta (dia): '
    end while !@user_input.validate_date_input(type: 'day')

    @user.add_goal(name, expected_amount, year, month, day)
    puts "\nLa meta #{name} ha sido creado con exito!"
  end

  def delete    
    begin
      print 'Nombre de la meta a eliminar: '
    end while !@user_input.validate_user_data_input(field: 'name')
    name = @user_input.last_input
    if !@user.search_goal(name).nil?
      puts "La meta #{name} ha sido cerrada con exito, el dinero esta disponible en la cuenta"
      @user.search_goal(name).delete(@user.account)
    else
      puts "\nLa meta #{name} no existe"
    end
  end
end