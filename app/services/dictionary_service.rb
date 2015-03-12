class DictionaryService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "https://api.pearson.com:443/v2/dictionaries/lase")
  end

  def dictionary(word)
    parse(connection.get("entries?headword=#{word}"))
  end

  # def school(id)
  #   parse(connection.get("schools/#{id}"))
  # end
  #
  # def destroy_school(id)
  #   connection.delete("schools/#{id}")
  # end

  private

  def parse(response)
    JSON.parse(response.body)["results"][0]["senses"][0]["translations"][0]["text"][0]
  end
end
