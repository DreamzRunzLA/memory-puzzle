require_relative "board"
require_relative "card"
require_relative "game"
require "byebug"

class ComputerPlayer
    def initialize
        @known_cards = Hash.new
        @matched_cards = []
    end

    def recieve_revealed_card
        return "cocksuck"
    end

    def recieve_match
        return "dicksuck"
    end

    

end