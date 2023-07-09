extends Node


var UIgame
var workspace

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func set_uigame(newGame: Node) -> void:
	UIgame = newGame
	
func set_workspace(newGame: Node) -> void:
	workspace = newGame
	
func pass_piece(piece: String) -> void:
	UIgame.get_piece(piece)
