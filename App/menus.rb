# class box that contains the definition of all the menus of the application
class Menus
  def initialize; end

  def main__menu
    "1. registrarse \n
    2. ingresar"
  end

  def mattress_menu
    "1. consultar dinero guardado \n
    2. agregar dinero \n
    3. retirar dinero \n
    4. regresar al menu \n"
  end

  def user_menu
    "1. consultar saldo disponible \n
    2. consultar saldo total \n
    3. recargar \n
    4. retirar \n
    5. enviar dinero \n
    6. consultar transacciones \n
    7. colchones \n
    8. bolsillos \n
    9. metas \n
    10. cerrar sesión \n"
  end

  def pocket_menu
    "1. listar bolsillos \n
    2. crear un nuevo bolsillo \n
    3. eliminar un bolsillo \n
    4. agregar dinero a un bolsillo \n
    5. retirar dinero de un bolsillo \n
    6. enviar dinero a otro usuario \n
    7. regresar al menu"
  end

  def goal_menu
    "1. listar metas \n
    2. crear una nueva meta \n
    3. cerrar una meta \n
    4. agregar dinero a una meta \n
    5. regresar al menu \n"
  end

  def login_menu
    "email: \n
    contraseña: \n"
  end

  def register_menu
    "nombre: \n
    apellido: \n
    email: \n
    contraseña: \n"
  end
end
