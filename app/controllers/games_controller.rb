class GamesController < ApplicationController
  before_action :authorize!

  def new
    words = Upload.with_meaning.shuffle
    @word = words.first
    @word_list = words[0..3].shuffle
    session[:word] = @word
    session[:word_list] = @word_list
  end

  def update
    # binding.pry
    if params[:guess] == session[:word]["meaning"]
      redirect_to new_game_path
    else
      render :new
    end
  end

  def check
  end
end
