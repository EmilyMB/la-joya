class DictionaryService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url:
      "https://api.pearson.com:443/v2/dictionaries/lase")
  end

  def dictionary(word)
    parse(connection.get("entries?headword=#{word}"))
  end

  private

  def parse(response)
    if JSON.parse(response.body)["results"].present?
      JSON.parse(response.body)["results"][0]["senses"][0]["translations"][0]["text"][0]
    else
      "no meaning"
    end
  end
end
