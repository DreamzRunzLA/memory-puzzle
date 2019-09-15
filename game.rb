require_relative "board"
require_relative "card"

class Game
    def initialize
        @board = Board.new
        @board.populate
        @previous_pos = []
    end

    def play
        # until @board.won? == true
            system("clear")
            @board.render
            puts "Enter a row and column!"
            input = gets.chomp
            x = input[0]
            y = input[-1]
            guessed_pos = []
            guessed_pos << x.to_i
            guessed_pos << y.to_i
        # end
        return guessed_pos
    end

    def make_guess(arrayGuess)


    end


end