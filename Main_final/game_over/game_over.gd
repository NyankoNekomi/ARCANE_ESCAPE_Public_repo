extends Node2D

@onready var button = $Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#Audioplayer.play_sfx("game_over.mp3")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()
