class Card
    
    #Stores full alphabet into an array and makes it accessible as a constant
    VALUES = ("A".."Z").to_a

    #Class method goes on top
    def self.shuffled_pairs(num_pairs)
        #Reference the constant
        values = VALUES
        
        #Slick way to sample from your alphabet then multiply by 2 for the pairs
        values = values.shuffle.take(num_pairs) * 2
        values.shuffle
        #Another slick way to work through your array of letter pairs and create
        #a brand new card based on each letter, storing it in same array
        values.map { |val| self.new(val)}
    end

    #You are only making the value of the card accessible outside of the class
    attr_reader :value

    #Card only needs the letter to be initialized and is face-down by default
    def initialize(value, revealed = false)
        @value = value
        @revealed = revealed
    end

    #Need to write a hide method in case a card is flipped up but not a match
    def hide
        @revealed = false
    end

    #Your custom string method to depict cards on a board using a one line if
    #statement that first checks if the card has been revealed or not
    def to_s
        revealed? ? value.to_s : "*"
    end

    #Need to write a reveal method for when player flips up a card
    def reveal
        @revealed = true
    end

    #Necessary because we did not allow the attr_reader access to this instance
    #variable
    def revealed?
        @revealed
    end

    #This is how you check for two card equality, must confirm they are both
    #cards and confirm that they contain the same value. Default object equality
    #would not work here
    def ==(object)
        object.is_a?(self.class) && object.value == value
    end


    #OLD CODE

    # attr_accessor :face_value, :face_up

    # def initialize(letter='')
    #     @face_value = letter
    #     @face_up = false
    # end

    # def hide
    #     self.face_up = false
    # end

    # def reveal
    #     self.face_up = true
    # end

    # def to_s
    #     return self.face_value
    # end

    # def ==(card)
    #     return self.to_s == card.to_s
    # end
end