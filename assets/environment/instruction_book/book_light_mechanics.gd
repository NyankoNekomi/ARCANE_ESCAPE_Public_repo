extends Node2D
@onready var label = $Control/Label
var is_body_in_area = false


func _ready():
	label.visible = false
	

func _on_area_2d_body_entered(body):
	is_body_in_area = true
	Audioplayer.play_sfx("book_01.ogg")
	#label.visible = true
	#label.text = str("Press enter to interact")

func _on_area_2d_body_exited(body):
	is_body_in_area = false
	DialogueSceneGlobal.book_read1 = false
	#label.visible = false

func _process(delta):
	if is_body_in_area and DialogueSceneGlobal.book_read1 == false:
		DialogueManager.show_example_dialogue_balloon(load("res://instruction_dialogue/light_mechanic_healing.dialogue"),"light_heal")
		DialogueSceneGlobal.book_read1 = true
