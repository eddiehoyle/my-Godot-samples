extends EntityMotionState

var _height: float = 0.0
var _vertical_speed: float = 0.0

func _get_height() -> float:
	return entity.global_transform.origin.y

func enter() -> void:
	_vertical_speed = entity.jump_power


func handle_input(event: InputEvent) -> void:
	if Input.is_action_pressed("jump"):
		return
	.handle_input(event)


func physics_update(delta: float) -> void:
	
	# Jump
	_vertical_speed += entity.gravity * delta
	_height = max(0.0, _height + _vertical_speed * delta)
	entity.pivot.position.y = min(0.0, -_height)
	
	# Note: This pattern hints at which is the next state. Alternative
	#		patterns might use pop() where the last known state would
	#		be transitioned to. This implies that after jump state is
	#		finished we _must_ go back to the state that triggered the
	#		transition.
	#
	#		Using stack:
	#			move (transition) jump (pop) move
	#
	#		Suppose user stops pressing move after jump:
	#			move (transtion) jump (pop) move (transtion) idle
	#											 ^ requires tick
	#
	#		I don't know if a stack works better when state maps get
	#		complex, so I'm going to pick explicit over stack for now.
	var input_vector: Vector2 = get_input_vector().normalized()
	if _height <= 0.0:
		if input_vector:
			emit_signal("next", "Move")
		else:
			emit_signal("next", "Idle")
		return

	# Move
	var velocity = entity.velocity.move_toward(input_vector * entity.max_speed, entity.air_acceleration * delta)
	entity.velocity = entity.move_and_slide(velocity)
	
	
