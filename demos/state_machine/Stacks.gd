extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var label: Label = $Panel/State

# Called when the node enters the scene tree for the first time.
func _ready():
	var sm = get_node("../Entity/StateMachine")
	label.text = sm.current_state.name
	sm.connect("state_changed", self, "_update_label")
	
func _update_label(state: State):
	label.text = state.name
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
