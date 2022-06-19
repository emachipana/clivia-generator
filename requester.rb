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

  def save
    puts "-" * 50
    puts "Do you want to save your score? (y/n)".colorize(mode: :bold, color: :green)
    confirm = get_inputs("Y y N n")
    if confirm.upcase == "Y"
      puts "Type the name to assign to the score".colorize(mode: :bold, color: :green)
      print "> ".colorize(mode: :bold, color: :yellow)
      name = gets.chomp
      name = name.empty? ? "Anonymous" : name.capitalize
      data = { name: name, score: score }
      save(data)
    end
  end

end