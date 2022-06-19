module Requester
  def menu_action(option)
    menus = {
      main_menu: "random | scores | exit".colorize(mode: :italic, color: :cyan)
    }
    menus[option]
  end

  def get_inputs(options)
    print "> ".colorize(mode: :bold, color: :yellow)
    input = gets.chomp
    input = empty(input)
    until options.include?(input)
      puts "Please type a valid option".colorize(color: :red, background: :light_white, mode: :bold)
      print "> ".colorize(mode: :bold, color: :yellow)
      input = gets.chomp
    end
    input
  end

  def isEmpty(input)
    while input.empty?
      puts "Cannot be blank".colorize(color: :red, background: :light_white, mode: :bold)
      print "> ".colorize(mode: :bold, color: :yellow)
      input = gets.chomp
    end
    input
  end
  
end