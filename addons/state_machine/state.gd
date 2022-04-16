extends Node
class_name State

# warning-ignore:unused_signal
signal finished(next_state_name)


# Called by the state machine upon changing the active state.
func enter() -> void:
	pass


# Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass


# All methods below are virtual and called by the state machine.
func handle_input(_event: InputEvent) -> void:
	pass


# Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass


# Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass


