extends EntityMotionState


func handle_input(event: InputEvent) -> void:
	var input_vector = get_input_vector()
	if input_vector:
		emit_signal("next", "Move")
	.handle_input(event)


func physics_update(delta: float) -> void:
	var velocity = entity.velocity.move_toward(Vector2.ZERO, entity.friction * delta)
	entity.velocity = entity.move_and_slide(velocity)
