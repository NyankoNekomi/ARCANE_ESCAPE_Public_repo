extends Node

@onready var key = $Key
var key_hold = false
# Called when the node enters the scene tree for the first time.
@onready var gate = $Gate

func _on_maze_body_exited(body):
	get_tree().reload_current_scene()
	print("Player is at the danger zone revert to start")


func _on_key_body_entered(body):
		if body.name == "player2":
			key_hold = true
			print(body.name)


func _on_gate_body_entered(body):
	if body.name == "player2" and key_hold == true:
		key_hold ==false

