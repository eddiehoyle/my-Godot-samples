extends EntityState


func get_input_vector() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

func handle_input(_event: InputEvent) -> void:
	var input_vector = get_input_vector()
	if not input_vector:
		emit_signal("finished", "Idle")
	
	
func physics_update(delta: float) -> void:
	var input_vector: Vector2 = get_input_vector().normalized()
	var velocity = entity.velocity.move_toward(input_vector * entity.max_speed, entity.acceleration * delta)
	entity.velocity = entity.move_and_slide(velocity)
	

	
