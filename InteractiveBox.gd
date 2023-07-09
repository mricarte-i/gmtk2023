extends Spatial

export var PieceName = "S"
export(Texture) var Preview
export var Cooldown = 5
export var MAX_ITEMS = 3

var inventory = MAX_ITEMS

onready var preview = $preview
onready var reload = $reload

onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reload.visible = false
	preview.texture = Preview

func _process(delta: float) -> void:
	if inventory == 0:
		start_reload()


func start_reload() -> void:
	preview.modulate = Color(64, 64, 64, 0.5)
	reload.visible = true
	timer.start()
	
func finish_reload() -> void:
	preview.modulate = Color(255, 255, 255, 1)
	reload.visible = false


func interaction(player: Object) -> void:
	print("hehe", PieceName)

func _on_Timer_timeout() -> void:
	finish_reload()
