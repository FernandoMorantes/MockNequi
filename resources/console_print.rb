# class responsible for giving the console colored prints and cleaned of the same
class ConsolePrint
  def clear_console
    system('cls') || system('clear')
  end

  def mock_loading(string)
    print_cyan string
    sleep(0.7)
    print_cyan '.'
    sleep(0.7)
    print_cyan '.'
    sleep(0.7)
    print_cyan ".\n \n"
    sleep(0.3)
  end

  def print_money(money)
    print_green_bold "$ #{format_money(money)}"
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

  def wait_for_enter
    print_blue "\n\n \t\t\t\t\t Presiona enter para continuar... \n"
    STDIN.noecho(&:gets).chomp
  end

  # color printing

  def print_black(string)
    print "\e[0;30m#{string}\e[m"
  end

  def print_blue(string)
    print "\e[0;34m#{string}\e[m"
  end

  def print_green(string)
    print "\e[0;32m#{string}\e[m"
  end

  def print_cyan(string)
    print "\e[0;36m#{string}\e[m"
  end

  def print_red(string)
    print "\e[0;31m#{string}\e[m"
  end

  def print_purple(string)
    print "\e[0;35m#{string}\e[m"
  end

  def print_brown(string)
    print "\e[0;33m#{string}\e[m"
  end

  def print_black_bold(string)
    print "\e[1;30m#{string}\e[m"
  end

  def print_blue_bold(string)
    print "\e[1;34m#{string}\e[m"
  end

  def print_green_bold(string)
    print "\e[1;32m#{string}\e[m"
  end

  def print_cyan_bold(string)
    print "\e[1;36m#{string}\e[m"
  end

  def print_red_bold(string)
    print "\e[1;31m#{string}\e[m"
  end

  def print_purple_bold(string)
    print "\e[1;35m#{string}\e[m"
  end

  def print_brown_bold(string)
    print "\e[0;33m#{string}\e[m"
  end
end
