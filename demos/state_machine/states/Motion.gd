extends EntityState
class_name EntityMotionState


func get_input_vector() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

func handle_input(event: InputEvent) -> void:
	if Input.is_action_pressed("jump"):
		emit_signal("finished", "Jump")
	.handle_input(event)
