require_relative "card"

class Board

    #Only attribute you want to read from the board is its size
    attr_reader :size

    #default size will be 4, you are storing the grid in @rows, slick to call
    #populate function within initialize
    def initialize(size=4)
        @rows = Array.new(size) { Array.new(size) }
        @size = size
        populate
    end

    #important method that will allow you to take 2 ints and access the grid
    #using nested array syntax
    def [](pos)
        row, col = pos
        rows[row][col]
    end

    #similar to above method except that you are now assigning a value to that
    #pos
    def []=(pos, value)
        row, col = pos
        rows[row][col] = value
    end

    #This is how you will hide cards, relies on method from Card class
    def hide(pos)
        self.[](pos).hide
    end

    #Check if card has been revealed already, then access that element on the 
    #grid and reveal it. At end of function, you want to return the value of the
    #card that has just been revealed for use in other functions
    def reveal(pos)
        if revealed?(pos)
            puts "Card already flipped"
        else
            self.[](pos).reveal
        end

        return self[pos].value
    end

    #Starts by calculating the number of pairs based on grid size
    #Then calls on the shuffled_pairs command to get the cards
    #Finally, it loops through the grid in double nested fashion to assign
    #One card per slot
    def populate
        num_pairs = (size**2) / 2
        cards = Card.shuffled_pairs(num_pairs)
        rows.each_index do |i|
            rows[i].each_index do |j|
                self[[i, j]] = cards.pop
            end
        end
    end

    #Starts by cleaing the board, then puts an entire row dedicated to labelling
    #The columns, then loops through each row and indicates the row number
    #concatenated with the contents of that full row. Very slick
    def render
        system("clear")
        puts "   #{(0...size).to_a.join(' ')}"
        rows.each_with_index do |row, i|
            puts "#{i} #{row.join(' ')}"
        end
    end

    #Simple method to check if the card at that position on the board has yet
    #to be revealed
    def revealed?(pos)
        self.[](pos).revealed?
    end

    #Takes the revealed method and checks across all cards on the grid if they
    #have in fact been revealed
    def won?
        rows.all? do |row|
            row.all?(&:revealed?)
        end
    end

    #Only want to make the rows accessible from outside the class
    attr_reader :rows




    #OLD CODE

    # attr_accessor :grid

    # def initialize(size = 4)
    #     @grid = Array.new(size) {Array.new(size, "")}
    #     @size = size
    #     populate
    # end

    # def populate
    #     possible_cards = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    #     possible_indices = self.generateIndices(4, 4).shuffle

    #     while possible_cards != []
    #         card_to_add = possible_cards.delete(possible_cards.sample)
    #         ind1 = possible_indices.pop
    #         ind2 = possible_indices.pop
    #         @grid[ind1[0]][ind1[1]] = Card.new(card_to_add)
    #         @grid[ind2[0]][ind2[1]] = Card.new(card_to_add)
    #     end

    #     return @grid

    # end

    # def [](pos)
    #     x, y = pos
    #     return @grid[x][y]
    # end

    # def [](pos, value)
    #     x, y = pos
    #     @grid[x][y] = value
    # end

    # def render
    #     board = Hash.new
    #     puts "#{(0...4).to_a.join(' ')}"   
    #     (0..3).each do |row|
    #         (0..3).each do |col|
    #             if @grid[row][col].face_up == true
    #                 board["#{row}#{col}"] = @grid[row][col].face_value + ' '
    #             else
    #                 board["#{row}#{col}"] = "* "
    #             end
    #             print board["#{row}#{col}"]
    #         end
    #         puts
    #     end
    # end

    # def won?
    #     @grid.each do |row|
    #         row.each do |card|
    #             if card.face_up == false
    #                 return false
    #             end
    #         end
    #     end
    #     true
    # end

    # def reveal(guessed_pos)
    #     x, y = guessed_pos
    #     if @grid[x][y].face_up == true
    #         return
    #     else
    #         @grid[x][y].face_up = true
    #         return @grid[x][y].face_value
    #     end
    # end

    # def generateIndices(rows, cols)
    #     ans = []
    #     allRows = (0...rows).to_a
    #     allCols = (0...cols).to_a
    #     allRows.each do |row|
    #         allCols.each do |col|
    #             ans << [row, col]
    #         end
    #     end
    #     return ans
    # end
end