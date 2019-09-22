load "game.rb"
testBoard = Board.new

testBoard.populate

testAI = ComputerPlayer.new(testBoard)

testAI.prompt