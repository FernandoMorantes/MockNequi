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
        @user_input.read_console_input
        puts "\nLa opcion ingresada esta mal escrita o no es valida" unless @user_input.validate_menu_input(menu_type: 'pocket')
      end while !@user_input.validate_menu_input(menu_type: 'pocket')

      if @user_input.menu_input.option == 'listar bolsillos'
        puts "\nLista de bolsillos:"
        @user.pockets.each do |pocket|
          puts pocket.to_string if pocket.active == true
        end

      elsif @user_input.menu_input.option == 'crear un nuevo bolsillo'
        begin
          print 'Nombre del bolsillo: '
          @user_input.read_console_input
          @user_input.validate_user_data_input(field: 'name') ? name = @user_input.last_input : puts('El nombre debe tener mas de 2 caracteres')
        end while !@user_input.validate_user_data_input(field: 'name')

        @user.add_pocket(name)
        puts "\nEl bolsillo #{name} ha sido creado con exito!"

      elsif @user_input.menu_input.option == 'eliminar un bolsillo'
        begin
          print 'Nombre del bolsillo a eliminar: '
          @user_input.read_console_input
          @user_input.validate_user_data_input(field: 'name') ? name = @user_input.last_input : puts('El nombre debe tener mas de 2 caracteres')
        end while !@user_input.validate_user_data_input(field: 'name')

        if !@user.search_pocket(name).nil?
          @user.search_pocket(name).delete(@user.account)
          puts "\nEl bolsillo #{name} ha sido eliminado, el saldo ahora esta disponible en la cuenta"
        else
          puts "\nEl bolsillo #{name} no existe"
        end

      elsif @user_input.menu_input.option == 'agregar dinero a un bolsillo'
        begin
          print 'Nombre del bolsillo: '
          @user_input.read_console_input
          @user_input.validate_user_data_input(field: 'name') ? name = @user_input.last_input : puts('El nombre debe tener mas de 2 caracteres')
        end while !@user_input.validate_user_data_input(field: 'name')

        if !@user.search_pocket(name).nil?
          begin
            print 'ingrese la cantidad de dinero que desea guardar en el bolsillo: '
            @user_input.read_console_input
            @user_input.validate_amount_input ? amount = @user_input.last_input : puts('El valor ingresado no es valido')
          end while !@user_input.validate_amount_input

          if @user.search_pocket(name).deposit(amount.to_i, @user.account)
            puts "\nDinero depositado en el bolisllo #{name} con exito!"
          else
            puts "\nLa cantidad a depositar no esta disponible en su cuenta"
          end

        else
          puts "\nEl bolsillo #{name} no existe"
        end

      elsif @user_input.menu_input.option == 'retirar dinero de un bolsillo'
        begin
          print 'Nombre del bolsillo: '
          @user_input.read_console_input
          @user_input.validate_user_data_input(field: 'name') ? name = @user_input.last_input : puts('El nombre debe tener mas de 2 caracteres')
        end while !@user_input.validate_user_data_input(field: 'name')

        if !@user.search_pocket(name).nil?
          begin
            print 'ingrese la cantidad de dinero que desea retirar del bolsillo: '
            @user_input.read_console_input
            @user_input.validate_amount_input ? amount = @user_input.last_input : puts('El valor ingresado no es valido')
          end while !@user_input.validate_amount_input

          if @user.search_pocket(name).withdraw(amount.to_i, @user.account)
            puts "\nDinero retirado del bolsillo #{name} con exito!"
          else
            puts "\nLa cantidad a retirar no esta disponible en el bolsillo #{name}"
          end

        else
          puts "\nEl bolsillo #{name} no existe"
        end

      elsif @user_input.menu_input.option == 'enviar dinero a otro usuario'
        begin
          print 'Nombre del bolsillo: '
          @user_input.read_console_input
          @user_input.validate_user_data_input(field: 'name') ? name = @user_input.last_input : puts('El nombre debe tener mas de 2 caracteres')
        end while !@user_input.validate_user_data_input(field: 'name')

        if !@user.search_pocket(name).nil?
          begin
            print 'Direccion de correo a la cual desea enviar el dinero: '
            @user_input.read_console_input
            @user_input.validate_user_data_input(field: 'email') ? email = @user_input.last_input : puts('El correo ingresado no es valido')
          end while !@user_input.validate_user_data_input(field: 'email')

          begin
            print 'ingrese la cantidad de dinero que desea enviar: '
            @user_input.read_console_input
            @user_input.validate_amount_input ? amount = @user_input.last_input : puts('El valor ingresado no es valido')
          end while !@user_input.validate_amount_input

          if @user.search_pocket(name).transfer_money(email, amount.to_i)
            puts "\nEnvio realizado con exito!"
          else
            puts "\nLa cantidad a enviar no esta disponible el bolsillo\no el correo especificado no tiene una cuenta registrada"
          end

        else
          puts "\nEl bolsillo #{name} no existe"
        end

      end
    end while @user_input.menu_input.option != 'regresar al menu de usuario'
  end

  def goal_menu
    begin
      begin
        @menus_ui.show_goal_menu
        @user_input.read_console_input
        puts "\nLa opcion ingresada esta mal escrita o no es valida" unless @user_input.validate_menu_input(menu_type: 'goal')
      end while !@user_input.validate_menu_input(menu_type: 'goal')

      if @user_input.menu_input.option == 'listar metas'
        puts "\nLista de metas activas:"
        @user.goals.each do |goal|
          puts goal.to_string if goal.active == true
        end

        puts "\nLista de metas cumplidas:"
        @user.goals.each do |goal|
          if goal.active == false && goal.status == 'fulfilled'
            puts goal.to_string
          end
        end

        puts "\nLista de metas cerradas (sin completar):"
        @user.goals.each do |goal|
          if goal.active == false && goal.status != 'fulfilled'
            puts goal.to_string
          end
        end

      elsif @user_input.menu_input.option == 'crear una nueva meta'
        begin
          print 'Nombre de la meta: '
          @user_input.read_console_input
          @user_input.validate_user_data_input(field: 'name') ? name = @user_input.last_input : puts('El nombre debe tener mas de 2 caracteres')
        end while !@user_input.validate_user_data_input(field: 'name')

        begin
          print 'Ingrese la meta de dinero: '
          @user_input.read_console_input
          @user_input.validate_amount_input ? expected_amount = @user_input.last_input : puts('El valor ingresado no es valido')
        end while !@user_input.validate_amount_input

        puts 'Por favor ingrese el año, el mes y el dia de vencimiento de la meta en numeros'
        begin
          print 'Ingrese el plazo maximo de la meta (año): '
          @user_input.read_console_input
          @user_input.validate_date_input(type: 'year') ? year = @user_input.last_input.to_i : puts('El año ingresado no es valido')
        end while !@user_input.validate_date_input(type: 'year')

        begin
          print 'Ingrese el plazo maximo de la meta (mes): '
          @user_input.read_console_input
          @user_input.validate_date_input(type: 'month') ? month = @user_input.last_input.to_i : puts('El mes ingresado no es valido')
        end while !@user_input.validate_date_input(type: 'month')

        begin
          print 'Ingrese el plazo maximo de la meta (dia): '
          @user_input.read_console_input
          if @user_input.validate_date_input(type: 'day')
            if !(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)

              if month == 4 || month == 6 || month == 9 || month == 11
                if @user_input.last_input.to_i <= 30
                  day = @user_input.last_input.to_i
                else
                  day = 0
                  puts 'El dia ingresado no es valido'
                end

              else
                if @user_input.last_input.to_i <= 28
                  day = @user_input.last_input.to_i
                else
                  day = 0
                  puts 'El dia ingresado no es valido'
                end

              end
            else
              day = @user_input.last_input.to_i
            end
          else
            puts 'El dia ingresado no es valido'
          end
        end while !@user_input.validate_date_input(type: 'day') || day == 0

        @user.add_goal(name, expected_amount, year, month, day)
        puts "\nLa meta #{name} ha sido creado con exito!"

      elsif @user_input.menu_input.option == 'cerrar una meta'
        begin
          print 'Nombre de la meta a eliminar: '
          @user_input.read_console_input
          @user_input.validate_user_data_input(field: 'name') ? name = @user_input.last_input : puts('El nombre debe tener mas de 2 caracteres')
        end while !@user_input.validate_user_data_input(field: 'name')

        if !@user.search_goal(name).nil?
          puts "La meta #{name} ha sido cerrada con exito, el dinero esta disponible en la cuenta"
          @user.search_goal(name).delete(@user.account)
        else
          puts "\nLa meta #{name} no existe"
        end

      elsif @user_input.menu_input.option == 'agregar dinero a una meta'
        begin
          print 'Nombre de la meta: '
          @user_input.read_console_input
          @user_input.validate_user_data_input(field: 'name') ? name = @user_input.last_input : puts('El nombre debe tener mas de 2 caracteres')
        end while !@user_input.validate_user_data_input(field: 'name')

        if !@user.search_goal(name).nil?
          begin
            print 'ingrese la cantidad de dinero que desea agregar a la meta: '
            @user_input.read_console_input
            @user_input.validate_amount_input ? amount = @user_input.last_input : puts('El valor ingresado no es valido')
          end while !@user_input.validate_amount_input

          if @user.search_goal(name).deposit(amount.to_i, @user.account)
            puts "\nDinero agregado a la meta #{name} con exito!"
          else
            puts "\nLa cantidad a depositar no esta disponible en su cuenta"
          end

        else
          puts "\nLa meta #{name} no existe"
        end

      end
    end while @user_input.menu_input.option != 'regresar al menu de usuario'
  end
end
