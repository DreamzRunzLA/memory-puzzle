class Card
    attr_accessor :face_value, :face_up

    def initialize
        @face_value = ''
        @face_up = false
    end

    def hide
        self.face_up = false
    end

    def reveal
        self.face_up = true
    end

    def to_s
        return self.face_value
    end

    def ==(card)
        return self.to_s == card.to_s
    end
end