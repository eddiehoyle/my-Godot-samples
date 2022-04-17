extends EntityMotionState

var _enter_velocity = Vector2.ZERO
var _enter_height: float = 0.0
var _height: float = 0.0
var _horizontal_velocity = 0.0
var _vertical_velocity = 0.0

var _vertical_speed = 0.0

func _get_height() -> float:
	return entity.global_transform.origin.y

func enter() -> void:
	_enter_velocity = entity.velocity
	_enter_height = _get_height()
	_vertical_velocity = -entity.jump_power
	_vertical_speed = entity.jump_power
#	entity.velocity.y = -entity.jump_power


func handle_input(event: InputEvent) -> void:
	if Input.is_action_pressed("jump"):
		return
	.handle_input(event)



func physics_update(delta: float) -> void:
	var input_vector: Vector2 = get_input_vector().normalized()
	var velocity = entity.velocity.move_toward(input_vector * entity.max_speed, entity.air_acceleration * delta)
	entity.velocity = entity.move_and_slide(velocity)
	
	_vertical_speed -= entity.gravity * delta
	_height += _vertical_speed * delta
	_height = max(0.0, _height)
	entity.pivot.position.y = min(0.0, -_height)
	
	# Note: This pattern hints at which is the next state. Alternative
	#		patterns might use pop() where the last known signal would
	#		be transitioned to. This implies that after jump state is
	#		finished we _must_ go back to the state that triggered the
	#		transition.
	#
	#		Using stack:
	#			move (transition) jump (pop) move
	#
	#		Suppose user stops pressing move after jump:
	#			move (transtion) jump (pop) move (transtion) idle
	#
	#		I don't know if a stack works better when state maps get
	#		complex, so I'm going to pick explicit over stack for now.
	if _height <= 0.0:
		if input_vector:
			emit_signal("finished", "Move")
		else:
			emit_signal("finished", "Idle")
	

