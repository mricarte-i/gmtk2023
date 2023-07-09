extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

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
