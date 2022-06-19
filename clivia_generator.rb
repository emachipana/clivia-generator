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

end
