class MenuOption
  @option

  attr_reader :option

  def initialize(option_number:, menu_type:)
    set_main_menu_option(option_number: option_number) if menu_type == 'main'
    set_user_menu_option(option_number: option_number) if menu_type == 'user'
    set_mattress_menu_option(option_number: option_number) if menu_type == 'mattress'
    set_pocket_menu_option(option_number: option_number) if menu_type == 'pocket'
    set_goal_menu_option(option_number: option_number) if menu_type == 'goal'
  end

  def set_main_menu_option(option_number:)
    @option = 'registrarse' if option_number == 1
    @option = 'ingresar' if option_number == 2
    @option = 'cerrar el programa' if option_number == 3
  end

  def set_user_menu_option(option_number:)
    @option = 'consultar saldo disponible en la cuenta' if option_number == 1
    @option = 'consultar saldo total de la cuenta' if option_number == 2
    @option = 'ingresar dinero a la cuenta' if option_number == 3
    @option = 'retirar' if option_number == 4
    @option = 'enviar dinero' if option_number == 5
    @option = 'consultar transacciones' if option_number == 6
    @option = 'consultar colchon' if option_number == 7
    @option = 'consultar bolsillos' if option_number == 8
    @option = 'consultar metas' if option_number == 9
    @option = 'cerrar sesión' if option_number == 10
  end

  def set_mattress_menu_option(option_number:)
    @option = 'consultar dinero guardado' if option_number == 1
    @option = 'agregar dinero' if option_number == 2
    @option = 'retirar dinero' if option_number == 3
    @option = 'regresar al menu de usuario' if option_number == 4
  end

  def set_pocket_menu_option(option_number:)
    @option = 'listar bolsillos' if option_number == 1
    @option = 'crear un nuevo bolsillo' if option_number == 2
    @option = 'eliminar un bolsillo' if option_number == 3
    @option = 'agregar dinero a un bolsillo' if option_number == 4
    @option = 'retirar dinero de un bolsillo' if option_number == 5
    @option = 'enviar dinero a otro usuario' if option_number == 6
    @option = 'regresar al menu de usuario' if option_number == 7
  end

  def set_goal_menu_option(option_number:)
    @option = 'listar metas' if option_number == 1
    @option = 'crear una nueva meta' if option_number == 2
    @option = 'cerrar una meta' if option_number == 3
    @option = 'agregar dinero a una meta' if option_number == 4
    @option = 'regresar al menu de usuario' if option_number == 5
  end
end
