require_relative "board"
require_relative "card"
require_relative "game"
require "byebug"

class ComputerPlayer
    #only want to access and write over these two outside of computerplayer
    attr_accessor :previous_guess, :board_size

    #You initialize with a board size and keep track of it, also initialize two
    #hashes for storing all known cards and matched cards
    def initialize(size)
        @board_size = size
        @known_cards = {}
        @matched_cards = {}
        @previous_guess = nil
    end

    #Assigns the revealed card to a hash with the value as the card's value, 
    #Your implementation of perfect memory
    def recieve_revealed_card(pos, value)
        @known_cards[pos] = value
    end

    #Simply takes two matched cards and assigns their position as the key and 
    #the value as true. This greatly simplifies the process of checking if 
    #a card has been match by relying on its position
    def recieve_match(pos1, pos2)
        @matched_cards[pos1] = true
        @matched_cards[pos2] = true
    end


    #Basically determines if the guess is the first or second one based on
    #the status of previous_guess
    def get_input
        if @previous_guess
            second_guess
        else
            first_guess
        end
    end

    #We're using the underscore because all we care about is the pos
    #at the end even though we do need to check against the card's value
    def unmatched_pos
        #Create a variable of pos and some arbitrary value
        #Search the known cards hash and return the first instance where all
        #of the following preconditions are true
        (pos, _) = @known_cards.find do |pos, val|
            @known_cards.any? do |pos2, val2|
                (pos != pos2 && val != val2) &&
                !(@matched_cards[pos] || @matched_cards[pos2])
            end
        end

        return pos
    end

    def match_previous
        (pos, _) = @known_cards.find do |pos, val|
            pos != previous_guess && val == @known_cards[previous_guess] &&
            !@matched_cards[pos]
        end

        return pos
    end

    def first_guess
        unmatched_pos || random_guess
    end

    def second_guess
        match_previous || random_guess
    end

    def random_guess
        guess = nil

        until guess && !@known_cards[guess]
            guess = [rand(board_size), rand(board_size)]
        end

        return guess
    end


    #OLD CODE

    # def prompt
    #     input1 = 0
    #     #check through all the matched cards, if you have yet to guess any
    #     #card that has been matched, guess one of those matched pairs
    #     @matched_cards.each do |pair|
    #         if @previous_guesses.include?(pair) == false
    #             input1 = pair[0]
    #             break
    #         end
    #     end
    #     #if your input variable was not impacted by the logic above, set it
    #     #to a random card
    #     until @previous_guesses.include?(input1) == false && input1 != 0 do
    #         input1 = self.genRand
    #     end
    #     @previous_guesses << input1
    #     return input1

    #     #some tests
    #     # p "This is the input" + input.to_s
    #     # return @board.[](input).face_value

    # end

    # #To access card from Game class, GAMEOBJECT.board.[]([pos1, pos2]).face_value

    # def genRand
    #     x = rand(4)
    #     y = rand(4)
    #     ans = []
    #     ans << x
    #     ans << y
    #     return ans
    # end

    # def pairChecker(arrayToCheck, pos1, pos2)
    #     x = []
    #     y = []
    #     x << pos1
    #     x << pos2
    #     y << pos1
    #     y << pos2
    #     if arrayToCheck.include?(x) || arrayToCheck.include?(y)
    #         return true
    #     else
    #         return false
    #     end
    # end

end