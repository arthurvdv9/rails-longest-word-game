require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(26)).chr }.join
    return @letters
  end

  def letter_in_grid
    @word.chars.sort.all? { |letter| @letters.include?(letter) }
  end

  def score
    @word = params[:word];
    @letters = params[:letters]
    grid_letters = @letters.each_char { |letter| print letter, ''}
    if !letter_in_grid
      @result = "Sorry, but #{@word.upcase} can’t be built out of #{grid_letters}."
    elsif !english_word
      @result = "Sorry but #{@word.upcase} does not seem to be an English word."
    elsif letter_in_grid && !english_word
      @result = "Sorry but #{@word.upcase} does not seem to be an English word."
    else letter_in_grid && english_word
      @result = "Congratulation! #{@word.upcase} is a valid English word."
    end
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_dictionary = URI.open(url)
    word = JSON.parse(word_dictionary.read)
    return word['found']
  end
end
