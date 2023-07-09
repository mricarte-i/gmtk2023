extends Node
class_name TetrisSim

export(Texture) var tile_texture

onready var game = $"../Game"

#width= 10, height= 20
const WIDTH = 10
const HEIGHT = 20
var board: Array = []


var pieces = {
	"O": {
		0: 
			[
				[1,1],
				[1,1]
			],
		1: 
			[
				[1,1],
				[1,1]
			],
		2: 
			[
				[1,1],
				[1,1]
			],
		3: 
			[
				[1,1],
				[1,1]
			],
	},
	"S": {
		0: 
			[
				[0,1,1],
				[1,1,0]
			],
		1: 
			[
				[1,0],
				[1,1],
				[0,1]
			],
		2: 
			[
				[0,1,1],
				[1,1,0]
			],
		3: 
			[
				[1,0],
				[1,1],
				[0,1]
			],
	},
	"Z": {
		0: 
			[
				[1,1,0],
				[0,1,1]
			],
		1: 
			[
				[0,1],
				[1,1],
				[1,0]
			],
		2: 
			[
				[1,1,0],
				[0,1,1]
			],
		3: 
			[
				[0,1],
				[1,1],
				[1,0]
			],
	},
	"T": {
		0: 
			[
				[1,1,1],
				[0,1,0]
			],
		1: 
			[
				[1,0],
				[1,1],
				[1,0]
			],
		2: 
			[
				[0,1,0],
				[1,1,1]
			],
		3: 
			[
				[0,1],
				[1,1],
				[0,1]
			],
	},
	"L": {
		0: 
			[
				[0,0,1],
				[1,1,1]
			],
		1: 
			[
				[1,1],
				[0,1],
				[0,1]
			],
		2: 
			[
				[1,1,1],
				[1,0,0]
			],
		3: 
			[
				[1,0],
				[1,0],
				[1,1]
			],
	},
	"J": {
		0: 
			[
				[1,0,0],
				[1,1,1]
			],
		1: 
			[
				[0,1],
				[0,1],
				[1,1]
			],
		2: 
			[
				[1,1,1],
				[0,0,1]
			],
		3: 
			[
				[1,1],
				[1,0],
				[1,0]
			],
	},
	"I": {
		0: 
			[
				[1,1,1,1],
			],
		1: 
			[
				[1],
				[1],
				[1],
				[1]
			],
		2: 
			[
				[1,1,1,1],
			],
		3: 
			[
				[1],
				[1],
				[1],
				[1]
			],
	},
	
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	board.resize(HEIGHT)
	for i in range(HEIGHT):
		board[i] = []
		board[i].resize(WIDTH)
		for j in range(WIDTH):
			board[i][j] = 0

# TO DO: 
# clearLines()

func getBoard() -> Array:
	return board

func findBestPosition(pieceName: String) -> void:
	var bestScore = -1
	var bestNextBoard = board
	
	for rotation in range(4):
		var piece = getRotatedPiece(pieceName, rotation)
		#don't try to put a piece beyond the play area!
		for x in range(WIDTH - piece[0].size()):
			var evaluated = evaluatePosition(piece, x, rotation)
			var score = evaluated.score
			var sim = evaluated.sim
			
			if score > bestScore:
				bestScore = score
				bestNextBoard = sim
	
	#signal to game the score!
	#if it was -1 then game over!
	if bestScore == -1:
		game.game_over()
	
	board = bestNextBoard #hopefully this will update the drawn pieces...

func getRotatedPiece(piece: String, rotation: int) -> Array:
	return pieces[piece][rotation]

func evaluatePosition(piece: Array, x: int, rotation: int) -> Dictionary:
	var score = 0
	var simulatedBoard = board
	
	var finalPiecePos = Vector2(x, 0)
	finalPiecePos.y = findDropPosition(piece, finalPiecePos)
	
	if finalPiecePos.y == -1:
		score = -1
	else:
		simulatedBoard = simulateBoard(piece, finalPiecePos)
	
		score += getNumberOfClearedLines(simulatedBoard)
		score += getTallestPoint(simulatedBoard)
	
	return {"score": score, "sim": simulatedBoard}


func findDropPosition(piece: Array, pos: Vector2) -> int:
	var notOverTheTop = false
	var dropPos = pos.y
	while dropPos < HEIGHT - piece.size() and canMoveDown(piece, Vector2(pos.x, dropPos)):
		notOverTheTop = true
		if dropPos <= HEIGHT - piece.size() - 1:
			dropPos += 1
	
	#if first attempt fails, game over man!
	if !notOverTheTop:
		return -1
	
	#since it adds up until it fails
	dropPos -= 1
		
	return dropPos

func canMoveDown(piece: Array, pos: Vector2) -> bool:
	for i in range(piece.size()):
		for j in range(piece[i].size()):
			if(board[pos.y + i][pos.x + j] == 1 and piece[i][j] == 1):
				return false
			if pos.y + i >= HEIGHT or pos.x + j >= WIDTH:
				return false
	return true

func simulateBoard(piece: Array, pos: Vector2) -> Array:
	var sim = board.duplicate(true)
	for i in range(piece.size()):
		for j in range(piece[i].size()):
			if(piece[i][j] == 1):
				sim[pos.y + i][pos.x + j] = 1
	return sim
	
func getNumberOfClearedLines(b: Array) -> int:
	var clearedLines = 0
	for i in range(b.size()):
		var isFull = true
		for j in range(b[i].size()):
			if b[i][j] != 0:
				isFull = false
				break
		if isFull:
			clearedLines += 1
	return clearedLines
	
func getTallestPoint(b: Array) -> int:
	var height = 0
	for i in range(b.size()):
		var isEmpty = true
		for j in range(b[i].size()):
			if b[i][j] != 0:
				isEmpty = false
				break
		if !isEmpty:
			height = i
			break
			
	return height
