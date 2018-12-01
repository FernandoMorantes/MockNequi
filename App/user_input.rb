# class that validates all the options entered by the user
class UserInput
  @last_input
  @menu_input

  attr_reader :last_input, :menu_input

  def initialize; end

  def validate_menu_input(menu_type:)
    read_console_input
    return false unless /\A\d+\z/.match(@last_input)
    if !@last_input.to_i.between?(1, 3) && menu_type == 'main'
      puts "\nLa opcion ingresada esta mal escrita o no es valida"
      return false
    end
    return false if !@last_input.to_i.between?(1, 10) && menu_type == 'user'
    return false if !@last_input.to_i.between?(1, 4) && menu_type == 'mattress'
    return false if !@last_input.to_i.between?(1, 7) && menu_type == 'pocket'
    return false if !@last_input.to_i.between?(1, 5) && menu_type == 'goal'

    @menu_input = MenuOption.new(option_number: @last_input.to_i, menu_type: menu_type)
    true
  end

  def validate_user_data_input(field:)
    read_console_input
    if !@last_input.size.between?(2, 60) && field == 'name'
      puts 'el dato ingresado no es valido. Minimo 2 caracteres, maximo 60'
      return false
    end
    if !@last_input.size.between?(2, 60) && field == 'last name'
      puts 'el dato ingresado no es valido. Minimo 2 caracteres, maximo 60'
      return false
    end
    if (!@last_input.size.between?(6, 60) || !@last_input.include?('@') || !@last_input.include?('.com')) && field == 'email'
      puts 'el email ingresado no es valido'
      return false
    end
    if !@last_input.size.between?(5, 60) && field == 'password'
      puts 'la contraseña ingresada no es valida. Minimo 5 caracteres, maximo 60'
      return false
    end
    true
  end

  def validate_amount_input
    read_console_input
    /\A\d+\z/.match(@last_input)
  end

  def validate_date_input(type:)
    read_console_input
    return false unless /\A\d+\z/.match(@last_input)
    return false if !@last_input.to_i.between?(2018, 3000) && type == 'year'
    return false if !@last_input.to_i.between?(1, 12) && type == 'month'
    return false if !@last_input.to_i.between?(1, 31) && type == 'day'

    true
  end

  private

  def read_console_input
    @last_input = gets.chomp
  end
end
