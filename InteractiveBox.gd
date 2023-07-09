extends Spatial

export var PieceName = "S"
export(Texture) var Preview
var PieceItem = preload("res://Piece.tscn")

export var Cooldown = 5
export var MAX_ITEMS = 3
export var DISTANCE = 2

var inventory = MAX_ITEMS

onready var preview = $preview
onready var reload = $reload

onready var timer = $Timer
onready var sound = $AudioStreamPlayer

onready var outline = $outline

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	outline.visible = false
	reload.visible = false
	preview.texture = Preview



func start_reload() -> void:
	preview.modulate = Color(64, 64, 64, 0.5)
	reload.visible = true
	timer.start()
	
func finish_reload() -> void:
	preview.modulate = Color(255, 255, 255, 1)
	reload.visible = false
	inventory = MAX_ITEMS


func interaction(player: KinematicBody) -> void:
	if inventory > 0 :
		print("hehe", PieceName)
		var newPiece = PieceItem.instance()
		newPiece.init(Preview, PieceName)
		get_parent().add_child(newPiece)
		sound.play(0)
		inventory -= 1
		
		if inventory == 0:
			start_reload()
	
		newPiece.transform.origin =  player.transform.origin + Vector3.UP*DISTANCE


func _on_Timer_timeout() -> void:
	finish_reload()


func _on_Interactive_body_entered(body: Node) -> void:
	if body is KinematicBody:
		print("hovering ", PieceName)
		outline.visible = true


func _on_Interactive_body_exited(body: Node) -> void:
	if body is KinematicBody:
		print("no longer hovering ", PieceName)
		outline.visible = false
