require_relative "board"
require_relative "card"
require_relative "game"
require "byebug"

class HumanPlayer
    def prompt
        puts "Enter a row and column!"
        input = gets.chomp
        x = input[0]
        y = input[-1]
        guessed_pos = []
        guessed_pos << x.to_i
        guessed_pos << y.to_i
        return guessed_pos
    end
end