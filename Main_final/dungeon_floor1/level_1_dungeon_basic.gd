extends Node2D


@onready var vial_count_onscreen = 0
@onready var vial_scene = $player2/AbilityManager/detectionrangeabilitycontroller

@export var next_level : PackedScene
@onready var game_camera_2d = $GameCamera2D

@onready var game_over = $CanvasLayer/game_over

@onready var player_1 = $Player1
@onready var player_2 = $player2


# Called when the node enters the scene tree for the first time.
func _ready():
	
	vial_count_onscreen = vial_scene.vial_count
	game_camera_2d.make_current()
	game_over.visible = false
	
	if DialogueSceneGlobal.instruction_read == false:
		DialogueManager.show_example_dialogue_balloon(load("res://instruction_dialogue/start.dialogue"),"Begining_dialogue")
		
		#DialogueManager.show_dialogue_balloon(load("res://instruction_dialogue/conversation1.dialogue"),"knight_and_wizard_conversation")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	vial_count_onscreen = vial_scene.vial_count
	$CanvasLayer/Label.text = str(vial_count_onscreen)
	

	if player_1.current_health <= 0 or player_2.current_health <=0:
		Audioplayer.play_sfx("game_over.mp3")
		player_1.active_input = false
		player_2.active_input = false
		game_over.visible= true
	


func _on_exit_area_body_entered(body):
	if body.is_in_group("player1") or body.is_in_group("player2"):
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_packed(next_level)
