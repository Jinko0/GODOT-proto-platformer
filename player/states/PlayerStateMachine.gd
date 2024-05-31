extends StateMachine
class_name PlayerStateMachine

@export var animation_tree : AnimationTree

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transitioned.connect(on_child_transition)
			child.playback = animation_tree["parameters/playback"]
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state
