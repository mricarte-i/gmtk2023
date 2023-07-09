extends KinematicBody

var gravity = Vector3.DOWN * 12
export var speed = 12
export var acceleration = 20

var velocity = Vector3.ZERO
var motion = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func get_input(delta:float) -> void:
	motion.x = velocity.x
	motion.z = velocity.z
	
	var newMotionX = motion.x + acceleration*delta*(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))	
	var newMotionZ = motion.z + acceleration*delta*(Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward"))
	
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
	velocity = move_and_slide(motion, Vector3.UP)
