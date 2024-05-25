extends Node
class_name StateMachine

@export var initial_state : State
# A déplacer plus tard
#@export var animation_tree : AnimationTree

var states : Dictionary = {}
var current_state : State

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transitioned.connect(on_child_transition)
			
			# A deplacer plus tard
			#child.playback = animation_tree["parameters/playback"]
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name)
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
