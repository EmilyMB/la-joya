class Dictionary
  def self.service
    @service ||= DictionaryService.new
  end

  def self.find(word)
    service.dictionary(word)
  end

  # def self.update(id, params)
  #   service.update_school(id, params)
  # end
end
