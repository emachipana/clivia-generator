require_relative "requester"
require_relative "presenter"
require_relative "queries_api"
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

end
