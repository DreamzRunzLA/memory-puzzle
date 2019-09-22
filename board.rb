require_relative "card"

class Board
    attr_accessor :grid

    def initialize
        @grid = Array.new(4) {Array.new(4, "")}
    end

    def populate
        possible_cards = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
        possible_indices = self.generateIndices(4, 4).shuffle

        while possible_cards != []
            card_to_add = possible_cards.delete(possible_cards.sample)
            ind1 = possible_indices.pop
            ind2 = possible_indices.pop
            @grid[ind1[0]][ind1[1]] = Card.new(card_to_add)
            @grid[ind2[0]][ind2[1]] = Card.new(card_to_add)
        end

        return @grid

    end

    def [](pos)
        x, y = pos
        return @grid[x][y]
    end

    def render
        board = Hash.new   
        (0..3).each do |row|
            (0..3).each do |col|
                if @grid[row][col].face_up == true
                    board["#{row}#{col}"] = @grid[row][col].face_value + ' '
                else
                    board["#{row}#{col}"] = "* "
                end
                print board["#{row}#{col}"]
            end
            puts
        end
    end

    def won?
        @grid.each do |row|
            row.each do |card|
                if card.face_up == false
                    return false
                end
            end
        end
        true
    end

    def reveal(guessed_pos)
        x, y = guessed_pos
        if @grid[x][y].face_up == true
            return
        else
            @grid[x][y].face_up = true
            return @grid[x][y].face_value
        end
    end

    def generateIndices(rows, cols)
        ans = []
        allRows = (0...rows).to_a
        allCols = (0...cols).to_a
        allRows.each do |row|
            allCols.each do |col|
                ans << [row, col]
            end
        end
        return ans
    end
end