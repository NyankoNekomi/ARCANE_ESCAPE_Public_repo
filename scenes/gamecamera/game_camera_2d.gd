extends Camera2D

var target_position = Vector2.ZERO
var mid_point = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	acquire_target()
	global_position = global_position.lerp(target_position,1.0-exp(-delta ))


func acquire_target():
		var player1_nodes = get_tree().get_nodes_in_group("player1")
		var player2_nodes = get_tree().get_nodes_in_group("player2")
		
		if player1_nodes.size() > 0 and player2_nodes.size() > 0:
			var player1 = player1_nodes[0] as Node2D
			var player2 = player2_nodes[0] as Node2D
			mid_point = (player1.global_position + player2.global_position)/2
			target_position = mid_point
		
