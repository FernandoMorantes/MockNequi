class ConsolePrint < PrintStyle
    
    def clear_console
      system('cls') || system('clear')
    end
    
    def wait_for_enter
      print_blue "\n\n \t\t\t\t\t Presiona enter para continuar... \n"
      STDIN.noecho(&:gets).chomp
    end

    def format_money(money)
      money_format = ''
      count = 0
      money.to_s.split('').reverse.each do |number|
        if count == 3
          money_format += '.'
          count = 0
        end
        money_format += number.to_s
        count += 1
      end
      money_format.reverse
    end

    def mock_loading message:
      print_cyan message
      sleep(0.7)
      print_cyan '.'
      sleep(0.7)
      print_cyan '.'
      sleep(0.7)
      print_cyan ".\n \n"
      sleep(0.3)
    end
  
    def error error:
      print_red_bold error
    end

    def money_amount amount:
      print_money amount
    end
    
    def blue_message message:
      print_blue message
    end
    
    def cyan_message message:
      print_cyan message
    end

    def message message:
      puts message
    end

    def transaction_title title:
      print_purple_bold title
    end

    def transaction_info info:
      print_brown info
    end

    def transaction_withdraw amount:
      print_red amount
    end

    def transaction_deposit amount:
      print_green amount
    end

    def credentials_field field:
      print_green field
    end

    def success_message message:
      print_green_bold message
    end

    def welcome_message message:
      print_purple message
    end

    def title title:
      print_cyan_bold title
    end
    
end