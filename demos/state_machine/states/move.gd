extends EntityMotionState


func handle_input(event: InputEvent) -> void:
	var input_vector = get_input_vector()
	if not input_vector:
		emit_signal("next", "Idle")
	.handle_input(event)

func physics_update(delta: float) -> void:
	var input_vector: Vector2 = get_input_vector().normalized()
	var velocity = entity.velocity.move_toward(input_vector * entity.max_speed, entity.acceleration * delta)
	entity.velocity = entity.move_and_slide(velocity)
