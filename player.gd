extends KinematicBody

var gravity = Vector3.DOWN * 12
export var speed = 12
export var acceleration = 20
export var REACH = 1.5

var velocity = Vector3.ZERO
var motion = Vector3.ZERO

onready var sprite = $Sprite3D
onready var interact = $InteractRayCast

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func get_input(delta:float) -> void:
	motion.x = velocity.x
	motion.z = velocity.z
	
	var zAction = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	var xAction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if xAction > 0:
		sprite.flip_h = true
	elif xAction < 0:
		sprite.flip_h = false
	
	var pointing = Vector2(xAction, zAction)
	if(Vector2.ZERO != pointing):
		interact.cast_to = Vector3(xAction, 0, zAction) * REACH
	
	var newMotionX = motion.x + acceleration*delta*(xAction)
	var newMotionZ = motion.z + acceleration*delta*(zAction)
	
	if newMotionX == velocity.x and newMotionZ == velocity.z:
		newMotionX = lerp(newMotionX, 0, 0.2)
		newMotionZ = lerp(newMotionZ, 0, 0.2)
		
	motion.x = newMotionX
	motion.z = newMotionZ #min(abs(newMotionZ), speed) * sign(newMotionZ)
	
	var normalize = Vector2(motion.x, motion.z)
	normalize = normalize.clamped(speed)
	motion = Vector3(normalize.x, velocity.y, normalize.y)


func _physics_process(delta: float) -> void:
	velocity += gravity * delta
	get_input(delta)
	if interact.is_colliding():
		var thing = interact.get_collider()
		if thing is CSGBox:
			thing = thing.get_parent()
		if thing.has_method("interaction") and Input.is_action_just_pressed("interact"):
			thing.interaction(self)

	
	velocity = move_and_slide(motion, Vector3.UP)


func _on_DropArea_body_entered(body: Node) -> void:
	pass # Replace with function body.


func _on_DropArea_body_exited(body: Node) -> void:
	pass # Replace with function body.
