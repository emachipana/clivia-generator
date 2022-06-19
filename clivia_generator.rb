require_relative "requester"
require_relative "display"
require_relative "fetch-api"
require "colorize"
require "json"
require "terminal-table"

class CliviaGenerator
  include Requester
  include Presenter
  include Queries

  attr_accessor :filename, :score
  def initialize
    @filename = ARGV.shift
    @filename = "scores.json" if @filename.nil?
    @score = 0
  end

  def start
    File.open(filename, "a")
    action = ""
    until action == "exit"
      puts welcome.join("\n").colorize(color: :light_red, mode: :bold)
      puts menu_action(:main_menu)
      action = get_inputs(menu_action(:main_menu))
      case action
      when "random" then random_trivia
      when "scores" then puts print_scores
      when "exit" then puts bye.join("\n").colorize(color: :light_red, mode: :bold)
      else puts "Please type a valid option".colorize(color: :red, background: :light_white, mode: :bold)
      end
    end
  end

  def random_trivia
    @score = 0
    questions = Fetch.load_questions
    i = 1
    questions.each do |question|
      puts "#{i}.Category: #{question[:category]} | Difficulty:  #{question[:difficulty]}".colorize(color: :blue,
                                                                                                    mode: :bold)
      puts "  Question: #{question[:question]}".colorize(color: :blue, mode: :bold)
      ask_questions(question)
      i += 1
    end
    system("clear")
    puts "Well done! Your score is #{score}".colorize(color: :green, mode: :bold)
    save_confirm
  end

  def ask_questions(question)
    answers = load_answers(question)
    i = 1
    options = []
    answers.each do |value|
      puts "  #{i}. #{value}".colorize(color: :yellow, mode: :bold)
      options.push(i.to_s)
      i += 1
    end
    answer = get_inputs(options)
    correct_answer = question[:correct_answer].is_a?(Array) ? question[:correct_answer].join(" ") : question[:correct_answer]
    if answers[answer.to_i - 1] == correct_answer
      puts "  Well done!".colorize(color: :magenta, mode: :bold)
      @score += 10
    else
      puts "  #{answers[answer.to_i - 1]}... Incorrect!\n  The correct answer was: #{correct_answer}".colorize(
        color: :red, mode: :bold
      )
    end
  end

end
