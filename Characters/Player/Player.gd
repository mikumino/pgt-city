extends KinematicBody2D

const MAX_SPEED = 250
const ACCELERATION = 75
var motion = Vector2()

func _physics_process(delta):
	var input_vector = Vector2()
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		motion += input_vector * ACCELERATION
		motion = motion.clamped(MAX_SPEED)
	else:
		motion = motion.move_toward(Vector2.ZERO, ACCELERATION)
	
	move_and_slide(motion)
