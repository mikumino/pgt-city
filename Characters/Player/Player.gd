extends KinematicBody2D

const MAX_SPEED = 250
const ACCELERATION = 75
var motion = Vector2()
var activeObject = null
var isFree = true

func _physics_process(delta):
	# movement stuff
	var input_vector = Vector2()
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO && isFree:
		motion += input_vector * ACCELERATION
		motion = motion.clamped(MAX_SPEED)
	else:
		motion = motion.move_toward(Vector2.ZERO, ACCELERATION)
	
	move_and_slide(motion)
	
	# interaction stuff (is this stupid)
	if Input.is_action_just_pressed("check") && isFree:
		check()
	
func check():
	if activeObject != null:
		activeObject.interact()
		
func exit_interaction():
	isFree = true
	
func set_active_object(object):
	activeObject = object
