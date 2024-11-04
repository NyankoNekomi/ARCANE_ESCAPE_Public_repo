extends Node2D

@export var next_level : PackedScene
@onready var creditscene = $Creditscene/Control

# Called when the node enters the scene tree for the first time.
func _ready():
	creditscene.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_packed(next_level)
	Audioplayer.play_sfx("button_click.mp3")


func _on_creds_pressed():
	creditscene.visible = true
