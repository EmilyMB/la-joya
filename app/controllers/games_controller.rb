class GamesController < ApplicationController
  before_action :authorize!

  def new
    words = Upload.all.shuffle
    @word = words.first
    @word_list = words[0..3]
  end
end
