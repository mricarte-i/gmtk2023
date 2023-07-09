extends RigidBody


export var PieceName = "O"
export(Texture) var Preview

onready var preview = $preview

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	preview.texture = Preview

func init(newPrev: Texture, newName: String) -> void:
	Preview = newPrev
	PieceName = newName

func interaction(player: KinematicBody) -> void:
	if player.has_method("grab"):
		player.grab(self)

func get_info() -> String:
	return PieceName

func kill() -> void:
	queue_free()
