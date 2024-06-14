extends Label

var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	player.connect("gem_picked_up", _on_gem_picked_up)

func _on_gem_picked_up():
	text = "Gemmes : " + str(player.score)
