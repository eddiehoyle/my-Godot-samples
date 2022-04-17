extends Node
class_name StateMachine

signal state_changed(current_state)
signal state_ready(state)

export(NodePath) var start_state

onready var states_map = {}

var states_stack: Array = []
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
		var err: int = 0
		err = state.connect("finished", self, "_change_state")
		assert(err == 0, "Error [%s] connecting state: '%s.finished' to '%s._change_state'" % [err, state.get_path(), self.get_path()])
#		err  = state.connect("push", self, "_push_state")
#		assert(err == 0, "Error [%s] connecting state: '%s.push' to '%s._push_state'" % [err, state.get_path(), self.get_path()])
#		err = state.connect("pop", self, "_pop_state")
#		assert(err == 0, "Error [%s] connecting state: '%s.pop' to '%s._pop_state'" % [err, state.get_path(), self.get_path()])
	
	initialize(start_state)


func initialize(initial_state: State):
	set_active(true)
	states_stack.push_front(initial_state)
	current_state = states_stack[0] as State
	current_state.enter()


func set_active(value):
	_active = value
	set_physics_process(value)
	set_process_input(value)
	if not _active:
		states_stack = []
		current_state = null


func _unhandled_input(event: InputEvent):
	current_state.handle_input(event)


func _physics_process(delta):
	current_state.physics_update(delta)


func _process(delta):
	current_state.update(delta)


#func _push_state(state_name: String) -> void:
#	print("_push_state")
#	if not _active:
#		return
#
#	assert(state_name in states_map, "Entity '%s' state '%s' not found! Available: %s" % [self.get_path(), state_name, states_map.keys()])
#	states_stack.push_front(states_map[state_name])
#
#	current_state = states_stack[0]
#	emit_signal("state_changed", current_state)
#
#
#func _pop_state() -> void:
#	print("_pop_state")
#	if not _active:
#		return
#
#	states_stack.pop_front()
#
#	current_state = states_stack[0]
#	emit_signal("state_changed", current_state)
	
	

func _change_state(state_name: String):
	if not _active:
		return
	current_state.exit()
	assert(state_name in states_map, "Entity '%s' state '%s' not found! Available: %s" % [self.get_path(), state_name, states_map.keys()])

	states_stack[0] = states_map[state_name]

	current_state = states_stack[0]
	print("current_state: %s" % [current_state])
	emit_signal("state_changed", current_state)
	
	current_state.enter()

