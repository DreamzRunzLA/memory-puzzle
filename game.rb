require_relative "board"
require_relative "card"
require "byebug"

class Game
        attr_accessor :board, :previous_pos
    
    def initialize
        @board = Board.new
        @board.populate
        @previous_pos = []
    end

    def play
        until @board.won? == true
            system("clear")
            @board.render
            guessed_pos1 = self.prompt
            make_guess1(guessed_pos1)
            guessed_pos2 = self.prompt
            make_guess2(guessed_pos2)
        end
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

    def make_guess1(arrayGuess)
        @previous_pos = arrayGuess
        @board.reveal(arrayGuess)
        system("clear")
        @board.render
    end

    def make_guess2(arrayGuess)
        x, y = arrayGuess
        a, b = @previous_pos
        @board.reveal(arrayGuess)
        system("clear")
        @board.render
        sleep(2)
        if @board.grid[x][y].face_value == @board.grid[a][b].face_value
            @previous_pos = []
            return
        else
            @board.grid[x][y].face_up = false
            @board.grid[a][b].face_up = false
            @previous_pos = []
        end
    end


end