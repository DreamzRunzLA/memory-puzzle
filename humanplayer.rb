require_relative "board"
require_relative "card"
require_relative "game"
require "byebug"

class HumanPlayer
    attr_accessor :board

    def initialize(board_object)
        @board = board_object
    end

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

    def recieve_revealed_card
        return "var 1"
    end

    def recieve_match
        return "var 2"
    end

end