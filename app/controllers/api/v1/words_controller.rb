class Api::V1::WordsController < ApplicationController
  def index
    @words = Upload.with_meaning.select(:id, :meaning, :meaning_en, :url)
    render json: @words
  end

  def show
    @word = Upload.public_words.find_by(meaning: params[:id])
    render json: @word
  end
end
