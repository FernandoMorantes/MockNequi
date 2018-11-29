# class that contains the definition of all the menus of the application
class MenusUI

  def initialize; end

  def show_main_menu
    print "\nMenu principal \n
    1. registrarse
    2. ingresar
    3. cerrar el programa \n\nIngrese la opcion que desea seleccionar: "
  end

    def show_user_menu
    print "\nMenu de usuario \n
    1. consultar saldo disponible en la cuenta
    2. consultar saldo total de la cuenta
    3. ingresar dinero a la cuenta
    4. retirar
    5. enviar dinero
    6. consultar transacciones
    7. consultar colchon
    8. consultar bolsillos
    9. consultar metas
    10. cerrar sesión \n\nIngrese la opcion que desea seleccionar: "
  end

  def show_mattress_menu
    print "\nMenu colchon \n
    1. consultar dinero guardado
    2. agregar dinero
    3. retirar dinero
    4. regresar al menu de usuario \n\nIngrese la opcion que desea seleccionar: "
  end

  def show_pocket_menu
    print "\nMenu de bolsillos \n
    1. listar bolsillos
    2. crear un nuevo bolsillo
    3. eliminar un bolsillo
    4. agregar dinero a un bolsillo
    5. retirar dinero de un bolsillo
    6. enviar dinero a otro usuario
    7. regresar al menu de usuario \n\nIngrese la opcion que desea seleccionar:  "
  end

  def show_goal_menu
    print "\nMenu de metas \n
    1. listar metas
    2. crear una nueva meta
    3. cerrar una meta 
    4. agregar dinero a una meta
    5. regresar al menu de usuario \n\nIngrese la opcion que desea seleccionar: "
  end
  
end
