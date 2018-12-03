# class that validates all the options entered by the user
class UserInput
  @last_input

  def initialize
    @console_print = ConsolePrint.new
  end

  attr_reader :last_input

  # validates the option entered in the corresponding menu
  # @param menu_type: menu where the user is located
  def validate_menu_input(menu_type:)
    read_console_input
    return wrong(field_type: 'menu') unless /\A\d+\z/.match(@last_input)
    return wrong(field_type: 'menu') if !@last_input.to_i.between?(1, 3) && menu_type == 'main'
    return wrong(field_type: 'menu') if !@last_input.to_i.between?(1, 10) && menu_type == 'user'
    return wrong(field_type: 'menu') if !@last_input.to_i.between?(1, 4) && menu_type == 'mattress'
    return wrong(field_type: 'menu') if !@last_input.to_i.between?(1, 7) && menu_type == 'pocket'
    return wrong(field_type: 'menu') if !@last_input.to_i.between?(1, 5) && menu_type == 'goal'
    true
  end

  # validates the data that the user enters
  # depending on the field that is being filled
  # @param field: field that is being validated
  def validate_user_data_input(field:)
    field != 'password' ? read_console_input : read_console_password
    return wrong(field_type: 'user data') if !@last_input.size.between?(2, 60) && field == 'name'
    return wrong(field_type: 'user data') if !@last_input.size.between?(2, 60) && field == 'last name'
    return wrong(field_type: 'email') if (!@last_input.size.between?(6, 60) || !@last_input.include?('@') || !@last_input.include?('.com')) && field == 'email'
    return wrong(field_type: 'password') if !@last_input.size.between?(5, 60) && field == 'password'
    true
  end

  # validates a number entered, either money or a menu option
  def validate_amount_input
    read_console_input
    return wrong(field_type: 'amount') unless /\A\d+\z/.match(@last_input)
    true
  end

  # validates a date entered
  # depends on the type of date you want to validate
  # @param type: date type to validate
  # @param month: by default 0, it is used to validate a date of type day
  def validate_date_input(type:, month: 0)
    read_console_input
    return wrong(field_type: 'date') unless /\A\d+\z/.match(@last_input)
    return wrong(field_type: 'year') if !@last_input.to_i.between?(2018, 3000) && type == 'year'
    return wrong(field_type: 'month') if !@last_input.to_i.between?(1, 12) && type == 'month'
    return wrong(field_type: 'day') if !@last_input.to_i.between?(1, 31) && type == 'day'
    return validate_day(month) if type == 'day'
    true
  end

  private

  # validates the day entered by the user
  # return will depend on the month you have chosen
  # @param month: month chosen by the user
  def validate_day(month)
    if ![1, 3, 5, 7, 8, 10, 12].include?(month)
      if [4, 6, 9, 11].include?(month)
        (@last_input.to_i <= 30) ? (return true) : (return wrong(field_type: 'day'))
      else
        (@last_input.to_i <= 28) ? (return true) : (return wrong(field_type: 'day'))
      end
    else
      return true
    end
  end

  # reads passwords entered by console by the user
  def read_console_password
    @last_input = STDIN.noecho(&:gets).chomp
  end

  # reads user input by console
  def read_console_input
    @last_input = gets.chomp
  end

  # returns error messages according to the specified field
  # @param field_type: field which throw the error
  def wrong(field_type:)
    @console_print.error error:"\nError: la opcion ingresada no es valida\n" if field_type == 'menu'
    @console_print.error error:"\nError: el dato ingresado no es valido. Minimo 2 caracteres, maximo 60 \n" if field_type == 'user data'
    @console_print.error error:"\nError: la contraseña ingresada no es valida. Minimo 5 caracteres, maximo 60\n" if field_type == 'password'
    @console_print.error error:"\nError: el email ingresado no es valido\n" if field_type == 'email'
    @console_print.error error:"\nError: La cantidad ingresada no es valida\n" if field_type == 'amount'
    @console_print.error error:"\nError: la fecha ingresada no es valida\n" if field_type == 'date'
    @console_print.error error:"\nError: el año ingresado no es valido\n" if field_type == 'year'
    @console_print.error error:"\nError: el mes ingresado no es valido\n" if field_type == 'month'
    @console_print.error error:"\nError: el dia ingresado no es valido\n" if field_type == 'day'
    @console_print.wait_for_enter
    @console_print.clear_console
    false
  end
end
