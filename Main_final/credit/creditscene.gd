extends Node

@onready var control = $Control

# Called when the node enters the scene tree for the first time.
func _ready():
	#control.visible = false
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_close_pressed():
	control.visible = false
