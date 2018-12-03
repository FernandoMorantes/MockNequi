class PrintStyle
  
  def print_money(money)
    print_green_bold "$ #{format_money(money)}"
  end

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
