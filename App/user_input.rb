# class that validates all the options entered by the user
class UserInput
  @last_input

  attr_reader :last_input, :menu_input

  def initialize; end

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

  def validate_user_data_input(field:)
    field != 'password' ? read_console_input : read_console_password
    return wrong(field_type: 'user data') if !@last_input.size.between?(2, 60) && field == 'name'
    return wrong(field_type: 'user data') if !@last_input.size.between?(2, 60) && field == 'last name'
    return wrong(field_type: 'email') if (!@last_input.size.between?(6, 60) || !@last_input.include?('@') || !@last_input.include?('.com')) && field == 'email'
    return wrong(field_type: 'password') if !@last_input.size.between?(5, 60) && field == 'password'
    true
  end

  def validate_amount_input
    read_console_input
    return wrong(field_type: 'amount') unless /\A\d+\z/.match(@last_input)
    true
  end

  def validate_date_input(type:, month: 0)
    read_console_input
    return wrong(field_type: 'date') unless /\A\d+\z/.match(@last_input)
    return wrong(field_type: 'year') if !@last_input.to_i.between?(2018, 3000) && type == 'year'
    return wrong(field_type: 'month') if !@last_input.to_i.between?(1, 12) && type == 'month'
    return validate_day(month) if !@last_input.to_i.between?(1, 31) && type == 'day'
    true
  end

  private

  def validate_day(month)
    if ![1, 3, 5, 7, 8, 10, 12].include? month
      if [4, 6, 9, 11].include? month
        @user_input.last_input.to_i <= 30 ? (return true) : wrong(field_type: 'day')
      else
        @user_input.last_input.to_i <= 28 ? (return true) : wrong(field_type: 'day')
      end
    else
      true
    end
  end

  def read_console_password
    @last_input = STDIN.noecho(&:gets).chomp
  end

  def read_console_input
    @last_input = gets.chomp
  end

  def wrong(field_type:)
    puts 'la opcion ingresada no es valida' if field_type == 'menu'
    puts 'el dato ingresado no es valido. Minimo 2 caracteres, maximo 60' if field_type == 'user data'
    puts 'la contraseña ingresada no es valida. Minimo 5 caracteres, maximo 60' if field_type == 'password'
    puts 'el email ingresado no es valido' if field_type == 'email'
    puts 'La cantidad ingresada no es valida' if field_type == 'amount'
    puts 'la fecha ingresada no es valida' if field_type == 'date'
    puts 'el año ingresado no es valido' if field_type == 'year'
    puts 'el mes ingresado no es valido' if field_type == 'month'
    puts 'el dia ingresado no es valido' if field_type == 'day'
    false
  end
end
