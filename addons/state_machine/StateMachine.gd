extends Node
class_name StateMachine

signal state_changed(current_state)

export(NodePath) var start_state

onready var states_map = {}

var current_state: State = null
var _active = false setget set_active


func _ready():
	for node in get_children():
		if node is State:
			states_map[node.name] = node

	assert(not states_map.empty(), "No states found for state machine!")
	if not start_state:
		start_state = states_map[get_child(0).name]

	for state_name in states_map:
		var state = states_map[state_name]
		var err: int = state.connect("next", self, "_change_state")
		assert(err == 0, "Error [%s] connecting state: '%s.next' to '%s._change_state'" % [err, state.get_path(), self.get_path()])

	
	set_active(true)
	current_state = start_state as State
	current_state.enter()


func set_active(value):
	_active = value
	set_physics_process(value)
	set_process_input(value)
	if not _active:
		current_state = null


func _unhandled_input(event: InputEvent):
	current_state.handle_input(event)


func _physics_process(delta):
	current_state.physics_update(delta)


func _process(delta):
	current_state.update(delta)


func _change_state(state_name: String):
	if not _active:
		return
	assert(state_name in states_map, "Entity '%s' state '%s' not found! Available: %s" % [self.get_path(), state_name, states_map.keys()])
	current_state.exit()
	
	current_state = states_map[state_name]
	current_state.enter()
	emit_signal("state_changed", current_state)
	

