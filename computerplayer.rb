require_relative "board"
require_relative "card"
require_relative "game"
require "byebug"

class ComputerPlayer
    def initialize
        @known_cards = Hash.new { |h, k| h[k] = [] }
        @matched_cards = [[[1,2],[2,3]]]
        @previous_guesses = [[[3,0],[0,3]],[[1,1],[1,3]],[[1,2],[2,3]]]
    end

    def recieve_revealed_card(pos, value)
        return "cocksuck"
    end

    def recieve_match(pos1, pos2)
        return "dicksuck"
    end

    def prompt
        input = 0
        @matched_cards.each do |pair|
            if @previous_guesses.include?(pair) == false
                input = pair[0]
                @previous_guesses << pair
                break
            end
        end
        if input == 0
            input = self.genRand
        end

        


    end

    def genRand
        x = rand(4)
        y = rand(4)
        ans = []
        ans << x
        ans << y
        return ans
    end

    def pairChecker(arrayToCheck, pos1, pos2)
        x = []
        y = []
        x << pos1
        x << pos2
        y << pos1
        y << pos2
        if arrayToCheck.include?(x) || arrayToCheck.include?(y)
            return true
        else
            return false
        end
    end

    # The computer player's strategy should be as follows:

    # On its first guess, if it knows where 2 matching cards are, guess one of
    # them, otherwise guess randomly among cards it has not yet seen.
    # On its second guess, if its first guess revealed a card whose value
    # matches a known location, guess that location, otherwise guess randomly 
    # among cards it has not yet seen.
    # Now comes the tricky part. With the HumanPlayer, we didn't need to 
    # explicitly receive the data from the card we're flipping over; we just
    # read it off the terminal output. The computer won't be quite so savvy.
    # Let's write some methods to have it accept the revealed card information 
    # from the game:

    # receive_revealed_card should take in a position and the value of the card
    # revealed at that location. It should then store it in a @known_cards hash.
    # receive_match should take in two positions which are a successful match.
    # I stored these in an instance variable @matched_cards

end