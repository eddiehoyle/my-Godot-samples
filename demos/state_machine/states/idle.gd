extends EntityState


func get_input_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

func handle_input(_event: InputEvent) -> void:
	var input_direction = get_input_direction()
	if input_direction:
		emit_signal("finished", "Move")
	

func physics_update(delta: float) -> void:
	var velocity = entity.velocity.move_toward(Vector2.ZERO, entity.friction * delta)
	entity.velocity = entity.move_and_slide(velocity)
