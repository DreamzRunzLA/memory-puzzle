require_relative "board"
require_relative "card"
require_relative "humanplayer"
require_relative "computerplayer"
require "byebug"

class Game

    #Only want player to be accessible outside of the class
    attr_reader :player

    #Requires you to feed in a player, default size is 4
    #Creates a new board and sets the last guess to nil
    def initialize(player, size = 4)
        @board = Board.new(size)
        @previous_guess = nil
        @player = player
    end

    #First check if the previous guess exists, if it does not you just assign
    #your current (new) guess to previous guess
    #If it does exist, you then compare your new guess to the previous guess 
    #by calling on the match? method and seeing if it returns true. When it
    #does, you invoke the recieve_match method in order to store this match
    #And when it does not, you simply prompt the player to try again and 
    #hide the two cards from that particular turn
    #Finally, you reset the previous guess for the game class and the player
    #class to be nil in preparation for the next turn
    def compare_guess(new_guess)
        if previous_guess
            if match?(previous_guess, new_guess)
                player.recieve_match(previous_guess, new_guess)
            else
                puts "Try again"
                [previous_guess, new_guess].each { |pos| board.hide(pos)}
            end
            self.previous_guess = nil
            player.previous_guess = nil
        else
            self.previous_guess = new_guess
            player.previous_guess = new_guess
        end
    end

    #Here you are initially setting pos to be nil
    def get_player_input
        pos = nil

        #Do not end the loop until a valid position comes through and that
        #position is not simply nil
        until pos && valid_pos?(pos)
            #Once you recive a valid position, you can set the position to that
            #player's input and return it
            pos = player.get_input
        end

        return pos
    end

    #requires position as an argument
    def make_guess(pos)
        #invoking the recieve revealed card in order to allow player class
        #ability to access it
        #Also by calling the reveal command, you are revealing it to the board
        #And need to render the board in order to reflect this change
        revealed_value = board.reveal(pos)
        player.recieve_revealed_card(pos, revealed_value)
        board.render

        #Calling on the compare_guess to see if you have a match or if you
        #need to take another turn first
        compare_guess(pos)

        #For the UI, adds a 1 second delay
        sleep(1)
        #Need to re-render the board after delay
        board.render
    end

    #Simple method for checking if 2 positions are a match. You are relying on 
    #The card == operator to single out two cards on a board and see if the
    #operator returns true. This method also returns the evaluation of that as a
    #boolean
    def match?(pos1, pos2)
        board[pos1] == board[pos2]
    end

    #Meat and potatoes of the program
    def play
        #Keep looping and playing the game until the won? method returns true
        #for the baord
        until board.won?
            #Constantly render the board
            board.render
            #Constantly obtain the position for the player
            pos = get_player_input
            #Constantly have the player make a guess
            make_guess(pos)
        end

        puts "Congratualtions! You won."
    end

    #Important method that validates if the player is inputting a legal pos
    def valid_pos?(pos)
        #Check if input is array
        pos.is_a?(Array) &&
        #Check that only 2 values were given
            pos.count == 2 &&
            #Check that the numbers given fall within the boundaries of the board
            pos.all? { |x| x.between?(0, board.size - 1) }
    end

    private

    #Allowing the previous_guess to be modified outside the scope of the class
    attr_accessor :previous_guess
    #Allowing the board to be read outside the scope of the class
    attr_reader :board







# OLD CODE    
#     attr_accessor :board, :previous_pos, :player
    
#     def initialize(player)
#         @board = Board.new
#         @board.populate
#         @previous_pos = nil
#         @player = player
#     end

#     def play
#         until @board.won? == true
#             system("clear")
#             @board.render
#             guessed_pos1 = @player.prompt
#             make_guess1(guessed_pos1)
#             guessed_pos2 = @player.prompt
#             make_guess2(guessed_pos2)
#         end
#     end

#     def make_guess1(arrayGuess)
#         @previous_pos = arrayGuess
#         @board.reveal(arrayGuess)
#         system("clear")
#         @board.render
#     end

#     def make_guess2(arrayGuess)
#         x, y = arrayGuess
#         a, b = @previous_pos
#         @board.reveal(arrayGuess)
#         system("clear")
#         @board.render
#         sleep(2)
#         if @board.grid[x][y].face_value == @board.grid[a][b].face_value
#             @previous_pos = []
#             return
#         else
#             @board.grid[x][y].face_up = false
#             @board.grid[a][b].face_up = false
#             @previous_pos = []
#         end
#     end


end

#How you can test your code without having to constantly rerun
if $PROGRAM_NAME == __FILE__
    size = ARGV.empty? ? 4 : ARGV.shift.to_i
    Game.new(ComputerPlayer.new(size), size).play  
end