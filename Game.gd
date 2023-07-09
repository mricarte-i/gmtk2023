extends Node2D

onready var sim = $"../TetrisSim"
onready var board = $"../Camera2D/Control/tetris"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw_board()

func game_over() -> void:
	get_tree().quit()

func get_piece(piece: String) -> void:
	sim.findBestPosition(piece)
	
	draw_board()
	
func draw_board() -> void:
	var board = sim.getBoard()
	var rows = board.get_children()
	for i in range(rows.size()):
		for j in range(rows[i].size()):
			if board[i][j] == 1:
				rows[i][j].modulate = Color(255,255,255,1)
			else:
				rows[i][j].modulate = Color(0,0,0,0)
# TO DO:
# - connect to 3D world game, when a piece is in the dispatch zone,
# take it, read its pieceName, kill 3D piece, give pieceName to
# TetrisSim, it will say if gameover or if lines cleared or if +score.
#
# - if lines cleared are enough, congratulations!
# - if game over, its game over man
# - when not game over, show updated board (tile map? sprites?),
# update score gui andrestart countdown timer.
#
# - timer will countdown 20sec, if no piece in dispatch zone,
# pick random if this happens 3 times, game over man.
