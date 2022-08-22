require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    alphabet = ('A'..'Z').to_a
    @letters = []

    10.times do
      @letters.push(alphabet[Random.rand(10)])
    end
  end

  def score
    @word = params[:word]
    @message = "you won. #{@word} is worth #{@word.size*97}"
    @message = "#{@word} is not on the grid" unless included?(@word, params[:letters])
    @message = "#{@word} is not an english word." unless english_word?(@word)
  end
end

def english_word?(word)
  response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  json['found']
end

def included?(guess, grid)
  guess.upcase.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
end
