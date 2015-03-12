class Dictionary
  def self.service
    @service ||= DictionaryService.new
  end

  def self.find(word)
    service.dictionary(word)
  end
end
