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

  def save_confirm
    puts "-" * 50
    puts "Do you want to save your score? (y/n)".colorize(mode: :bold, color: :green)
    confirm = get_inputs("Y y N n")
    if confirm.upcase == "Y"
      puts "Type the name to assign to the score".colorize(mode: :bold, color: :green)
      print "> ".colorize(mode: :bold, color: :yellow)
      name = gets.chomp
      name = name.empty? ? "Anonymous" : name.capitalize
      data = { name: name, score: score }
      save(data) # method in clivia_generator.rb
    end
  end

  def load_answers(question)
    answers = []
    correct_answer = question[:correct_answer].is_a?(Array) ? question[:correct_answer].join(" ") : question[:correct_answer]
    first_incorrect_answer = question[:incorrect_answers][0].is_a?(Array) ? question[:incorrect_answers][0].join(" ") : question[:incorrect_answers][0]
    second_incorrect_answer = question[:incorrect_answers][1].is_a?(Array) ? question[:incorrect_answers][1].join(" ") : question[:incorrect_answers][1]
    third_incorrect_answer = question[:incorrect_answers][2].is_a?(Array) ? question[:incorrect_answers][2].join(" ") : question[:incorrect_answers][2]
    answers.push(correct_answer) unless question[:correct_answer].nil?
    answers.push(first_incorrect_answer) unless question[:incorrect_answers][0].nil?
    answers.push(second_incorrect_answer) unless question[:incorrect_answers][1].nil?
    answers.push(third_incorrect_answer) unless question[:incorrect_answers][2].nil?
    answers.sort_by! { rand }
  end

end