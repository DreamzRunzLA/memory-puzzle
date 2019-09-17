require_relative "board"
require_relative "card"
require_relative "game"
require "byebug"

class ComputerPlayer
    def initialize
        @known_cards = Hash.new
        @matched_cards = []
    end

    def prompt
        
    end
end