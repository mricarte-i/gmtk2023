extends Area

onready var timer = $Timer
var info: Node = null
onready var sound = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_DropArea_body_entered(body: Node) -> void:
	if body.has_method("get_info"):
		info = body
		timer.start()


func _on_DropArea_body_exited(body: Node) -> void:
	if body.has_method("get_info"):
		info = null
		timer.stop()


func _on_Timer_timeout() -> void:
	if info != null:
		#call tetris game and pass info.get_info()
		print("GOT ", info.get_info())
		info.kill()
		sound.play(0)
		print("GOGOGO")
	
