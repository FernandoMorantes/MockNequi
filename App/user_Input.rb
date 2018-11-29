# class that validates all the options entered by the user
class UserInput
  @last_input
  @menu_input

  attr_reader :last_input, :menu_input

  def initialize; end

  def read_console_input
    @last_input = gets.chomp
  end

  def validate_menu_input(menu_type:)
    return false unless /\A\d+\z/.match(@last_input)
    return false if !@last_input.to_i.between?(1, 3) && menu_type == 'main'
    return false if !@last_input.to_i.between?(1, 10) && menu_type == 'user'
    return false if !@last_input.to_i.between?(1, 4) && menu_type == 'mattress'
    return false if !@last_input.to_i.between?(1, 7) && menu_type == 'pocket'
    return false if !@last_input.to_i.between?(1, 5) && menu_type == 'goal'

    @menu_input = MenuOption.new(option_number: @last_input.to_i, menu_type: menu_type)
    true
  end

  def validate_user_data_input(field:)
    return false if !@last_input.size.between?(2, 60) && field == 'name'
    return false if !@last_input.size.between?(2, 60) && field == 'last name'
    return false if (!@last_input.size.between?(6, 60) || !@last_input.include?('@') || !@last_input.include?('.com')) && field == 'email'
    return false if !@last_input.size.between?(5, 60) && field == 'password'

    true
  end

  def validate_amount_input
    /\A\d+\z/.match(@last_input)
  end

  def validate_date_input(type:)
    return false unless /\A\d+\z/.match(@last_input)

    return false if !@last_input.to_i.between?(2018, 3000) && type == 'year'
    return false if !@last_input.to_i.between?(1, 12) && type == 'month'
    return false if !@last_input.to_i.between?(1, 31) && type == 'day'

    true
  end
end
