class MattressForm < ConsolePrint
  def initialize
    @user_input = UserInput.new
  end

  def form_deposit
    loop do
      print 'ingrese la cantidad de dinero que desea guardar en el colchon: '
      break if @user_input.validate_amount_input
    end
    @user_input.last_input.to_i
  end

  def form_withdraw
    loop do
      print 'ingrese la cantidad de dinero que desea retirar del colchon: '
      break if @user_input.validate_amount_input
    end
    @user_input.last_input.to_i
  end
end
