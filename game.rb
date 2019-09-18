require_relative "board"
require_relative "card"
require_relative "humanplayer"
require_relative "computerplayer"
require "byebug"

class Game
    attr_accessor :board, :previous_pos, :player
    
    def initialize(player)
        @board = Board.new
        @board.populate
        @previous_pos = []
        @player = player
    end

    def play
        until @board.won? == true
            system("clear")
            @board.render
            guessed_pos1 = @player.prompt
            make_guess1(guessed_pos1)
            guessed_pos2 = @player.prompt
            make_guess2(guessed_pos2)
        end
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