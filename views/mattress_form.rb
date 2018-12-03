class MattressForm
  def initialize
    @user_input = UserInput.new
    @console_print= ConsolePrint.new
  end

  def form_deposit
    loop do
      @console_print.blue_message message:"\ningrese la cantidad de dinero que desea guardar en el colchon: "
      break unless @user_input.validate_amount_input
    end
    @user_input.last_input.to_i
  end

  def form_withdraw
    loop do
      @console_print.blue_message message:"ingrese la cantidad de dinero que desea retirar del colchon: "
      break unless @user_input.validate_amount_input
    end
    @user_input.last_input.to_i
  end
end
