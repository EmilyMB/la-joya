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
    answer = session[:word]["meaning"]
    if params[:guess] == answer
      flash[:message] = "¡La adivinaste! La palabra fue '#{answer}' "\
                        "#{answer_en}"
      redirect_to new_game_path
    else
      flash[:alert] = "¡Intenta de nuevo!"
      render :new
    end
  end

  def check
  end

  private

  def answer_en
    answer = session[:word]["meaning_en"]
    if ![nil, "", "no meaning"].include? answer
      "o en inglés '#{answer}'"
    end
  end
end
