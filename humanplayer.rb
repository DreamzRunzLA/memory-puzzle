require_relative "board"
require_relative "card"
require_relative "game"
require "byebug"

class HumanPlayer

    attr_accessor :previous_guess

    #Due to duck typing, you are using the catch-all underscore character to
    #tell ruby to accept whatever comes its way but expressly singling out
    #size as an argument you do want to read and make use of
    def initialize(_size)
        @previous_guess = nil
    end

    #You only need to use the gets.chomp for human class
    def get_input
        #prompt is a custom function you defined to print to console a command
        #to the user
        prompt
        #parse is a custom function you are defining below to handle user input
        #STDIN will prioritize reading the user's input
        parse(STDIN.gets.chomp)
    end

    def prompt
        puts "please enter the pos of the card"
        print "> "
    end

    #This parser splits a string on the comma into an array then maps all
    #elements of that array to be integers instead of strings
    def parse(string)
        #You use Integer(x) here because it will throw an error if the number
        #is not a valid integer
        string.split(",").map { |x| Integer(x) }
    end

    def recieve_revealed_card(pos, value)
        #duck typing
    end

    def reviece_match(_pos1, _pos2)
        puts "It's a match!"
    end

    #OLD CODE

    # attr_accessor :board

    # def initialize(board_object)
    #     @board = board_object
    # end

    # def prompt
    #     puts "Enter a row and column!"
    #     input = gets.chomp
    #     x = input[0]
    #     y = input[-1]
    #     guessed_pos = []
    #     guessed_pos << x.to_i
    #     guessed_pos << y.to_i
    #     return guessed_pos
    # end

    # def recieve_revealed_card
    #     return "var 1"
    # end

    # def recieve_match
    #     return "var 2"
    # end

end