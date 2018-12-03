# class that contains the definition of all the menus of the application
class MenusUI < PrintStyle
  def initialize; end

  def show_main_menu
    print_blue_bold "\nMenu principal \n\n"
    print_purple_bold '1. '; print_blue_bold "Registrarse\n"
    print_purple_bold '2. '; print_blue_bold "Ingresar\n"
    print_purple_bold '3. '; print_blue_bold "Cerrar el programa \n\n"
    print_brown_bold 'Ingrese la opcion que desea seleccionar: '
  end

  def show_user_menu
    print_cyan_bold "\nMenu de usuario \n\n"
    print_purple_bold '1. '; print_blue_bold "Consultar saldo disponible en la cuenta\n"
    print_purple_bold '2. '; print_blue_bold "Consultar saldo total de la cuenta\n"
    print_purple_bold '3. '; print_blue_bold "Ingresar dinero a la cuenta\n"
    print_purple_bold '4. '; print_blue_bold "Retirar dinero de la cuenta\n"
    print_purple_bold '5. '; print_blue_bold "Enviar dinero a otro usuario\n"
    print_purple_bold '6. '; print_blue_bold "Consultar transacciones\n"
    print_purple_bold '7. '; print_blue_bold "Menu colchones \n"
    print_purple_bold '8. '; print_blue_bold "Menu bolsillos\n"
    print_purple_bold '9. '; print_blue_bold "Menu metas\n"
    print_purple_bold '10. '; print_blue_bold "Cerrar sesión \n\n"
    print_brown_bold 'Ingrese la opcion que desea seleccionar: '
  end

  def show_mattress_menu
    print_cyan_bold "\nMenu colchon \n\n"
    print_purple_bold '1. '; print_blue_bold "Consultar dinero guardado\n"
    print_purple_bold '2. '; print_blue_bold "Agregar dinero\n"
    print_purple_bold '3. '; print_blue_bold "Retirar dinero\n"
    print_purple_bold '4. '; print_blue_bold "Regresar al menu de usuario\n\n"
    print_brown_bold 'Ingrese la opcion que desea seleccionar: '
  end

  def show_pocket_menu
    print_cyan_bold "\nMenu de bolsillos \n\n"
    print_purple_bold '1. '; print_blue_bold "Listar bolsillos\n"
    print_purple_bold '2. '; print_blue_bold "Crear un nuevo bolsillo\n"
    print_purple_bold '3. '; print_blue_bold "Eliminar un bolsillo\n"
    print_purple_bold '4. '; print_blue_bold "Agregar dinero a un bolsillo\n"
    print_purple_bold '5. '; print_blue_bold "Retirar dinero de un bolsillo\n"
    print_purple_bold '6. '; print_blue_bold "Enviar dinero a otro usuario\n"
    print_purple_bold '7. '; print_blue_bold "Regresar al menu de usuario\n\n"
    print_brown_bold 'Ingrese la opcion que desea seleccionar: '
  end

  def show_goal_menu
    print_cyan_bold "\nMenu de metas \n\n"
    print_purple_bold '1. '; print_blue_bold "Listar metas\n"
    print_purple_bold '2. '; print_blue_bold "Crear una nueva meta\n"
    print_purple_bold '3. '; print_blue_bold "Cerrar una meta\n"
    print_purple_bold '4. '; print_blue_bold "agregar dinero a una meta\n"
    print_purple_bold '5. '; print_blue_bold "Regresar al menu de usuario\n\n"
    print_brown_bold 'Ingrese la opcion que desea seleccionar: '
  end
end
