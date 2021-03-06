require "httparty"
require "htmlentities"

module Fetch
  include HTTParty

  base_uri("https://opentdb.com/api.php?")

  def self.decode_questions(questions)
    decoder = HTMLEntities.new
    questions.each do |question|
      question[:question] = decoder.decode(question[:question])
      question[:correct_answer] = decoder.decode(question[:correct_answer])
      unless question[:incorrect_answers][0].nil?
        question[:incorrect_answers][0] =
          decoder.decode(question[:incorrect_answers][0])
      end
      unless question[:incorrect_answers][1].nil?
        question[:incorrect_answers][1] =
          decoder.decode(question[:incorrect_answers][1])
      end
      unless question[:incorrect_answers][2].nil?
        question[:incorrect_answers][2] =
          decoder.decode(question[:incorrect_answers][2])
      end
    end
  end

  def self.load_questions
    response = get("amount=10")
    raise HTTParty::ResponseError, response unless response.code == 200

    data = JSON.parse(response.body, symbolize_names: true)
    decode_questions(data[:results])
  end

end
