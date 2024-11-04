extends Node2D

@export var title_screen : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	Audioplayer.bgm.stream = Audioplayer.BGM_2
	Audioplayer.bgm.play()
	Audioplayer.bgm.volume_db = -10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_packed(title_screen)


func _on_quit_pressed():
	Audioplayer.play_sfx("button_click.mp3")
	get_tree().quit()
