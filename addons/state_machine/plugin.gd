tool
extends EditorPlugin


func _enter_tree():
	# Initialization of the plugin goes here.
	# Add the new type with a name, a parent type, a script and an icon.
	add_custom_type("StateMachine", "Node", preload("state_machine.gd"), preload("state_machine_icon.png"))
	add_custom_type("State", "Node", preload("state.gd"), preload("state_icon.png"))


func _exit_tree():
	# Clean-up of the plugin goes here.
	# Always remember to remove it from the engine when deactivated.
	remove_custom_type("StateMachine")
	remove_custom_type("State")