class UserMenu
  def initialize(user:, session:)
    @user = user
    @session = session
    @user_input = UserInput.new
    @menus_ui = MenusUI.new
    @menu_option = MenuOption.new(user: @user, user_menu: self)
  end

  def show
    begin
      begin
        @menus_ui.show_user_menu
      end until @user_input.validate_menu_input(menu_type: 'user')
    end while !@menu_option.do(menu_type: 'user', option_number: @user_input.last_input)
  end

  def mattress_menu
    begin
      begin
        @menus_ui.show_mattress_menu
      end while !@user_input.validate_menu_input(menu_type: 'mattress')
    end while !@menu_option.do(menu_type: 'mattress', option_number: @user_input.last_input)
  end

  def pocket_menu
    begin
      begin
        @menus_ui.show_pocket_menu
      end while !@user_input.validate_menu_input(menu_type: 'pocket')
    end while !@menu_option.do(menu_type: 'pocket', option_number: @user_input.last_input)
  end

  def goal_menu
    begin
      begin
        @menus_ui.show_goal_menu
      end while !@user_input.validate_menu_input(menu_type: 'goal')
    end while !@menu_option.do(menu_type: 'goal', option_number: @user_input.last_input)
  end
end
