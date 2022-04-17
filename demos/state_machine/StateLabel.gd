extends Label

func _ready():
	var sm = get_node("../../../StateMachine")
	text = sm.current_state.name
	sm.connect("state_changed", self, "_update_label")
	
func _update_label(state: State):
	text = state.name
	
	
