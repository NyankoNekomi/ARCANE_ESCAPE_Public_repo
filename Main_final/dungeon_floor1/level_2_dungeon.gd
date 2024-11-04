extends Node2D

const VIAL_LABEL = preload("res://Main_final/dungeon_floor1/vial_label.tres")
const SPAWN_RADIUS = 150
@export var next_level : PackedScene
@onready var game_over = $CanvasLayer/game_over

@onready var vial_count_onscreen = 0
@onready var vial_scene = $player2/AbilityManager/detectionrangeabilitycontroller
@onready var floor_1 = $floor_1

@onready var player =$Player1
@onready var player_2 = $player2

@onready var area_player1 = $Player1/PickUP
@onready var floor_2 = $floor_2

@onready var key = $key
@onready var key2 = $key2

@onready var enemy_spawn_timer_1 = $EnemySpawnTimer1
@onready var enemy_spawn_timer_2 = $EnemySpawnTimer2
@onready var game_camera_2d = $GameCamera2D
@export var rat_enemy_scene : PackedScene
@export var ghost_enemy_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	vial_count_onscreen = vial_scene.vial_count
	$CanvasLayer/Label.text = str(vial_count_onscreen)
	game_camera_2d.make_current()
	game_over.visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vial_count_onscreen = vial_scene.vial_count
	$CanvasLayer/Label.text = str(vial_count_onscreen)
	
	if player.current_health <=0 or player_2.current_health <=0:
		Audioplayer.play_sfx("game_over.mp3")
		player.active_input = false
		player_2.active_input = false
		game_over.visible = true
	

func _on_gatecheck_body_entered(body : CharacterBody2D):
			if body == null:
				return
			
			if key.key_check == true:
				if body.is_in_group("player1") or body.is_in_group("player2") :
					floor_2.set_layer_enabled(2,false)
					Audioplayer.play_sfx("unlock.ogg")
					key.key_check = false
					#key.queue_free()
					



func _on_posion_area_detect_body_entered(body):
	if body.is_in_group("player1") or body.is_in_group("player2"):
		var warninglabel = Label.new()
		add_child(warninglabel)
		warninglabel.label_settings = VIAL_LABEL
		warninglabel.text = "You entered the poison ground"
		warninglabel.position = game_camera_2d.global_position
		Audioplayer.play_sfx("poison.wav")
		await get_tree().create_timer(2).timeout
		get_tree().reload_current_scene()


func _on_enemy_spawn_timer_1_timeout():
	var rand_direction = Vector2.RIGHT.rotated(randf_range(0,TAU))
	var spawn_position = $enemyspawn_pos.global_position + (rand_direction * SPAWN_RADIUS)
	var rat_enemy = rat_enemy_scene.instantiate()
	add_child(rat_enemy)
	rat_enemy.position = spawn_position


func _on_enemy_spawn_timer_2_timeout():
	var rand_direction = Vector2.RIGHT.rotated(randf_range(0,TAU))
	var spawn_position = $enemyspawn_pos2.global_position + (rand_direction * SPAWN_RADIUS)
	var ghost_enemy = ghost_enemy_scene.instantiate()
	add_child(ghost_enemy)
	ghost_enemy.position = spawn_position

func _on_check_player_area_body_entered(body):
	if body.is_in_group("player1") or body.is_in_group("player2"):
		enemy_spawn_timer_1.start()


func _on_check_player_area_body_exited(body):
	if body.is_in_group("player1") or body.is_in_group("player2"):
		enemy_spawn_timer_1.start()



func _on_check_player_area_2_body_entered(body):
		if body.is_in_group("player1") or body.is_in_group("player2"):
			enemy_spawn_timer_2.start()




func _on_check_player_area_2_body_exited(body:Node2D):
		if body.is_in_group("player1") or body.is_in_group("player2"):
			enemy_spawn_timer_2.stop()



func _on_gate_check_2_body_entered(body:Node2D):
	if body == null:
				return
	if key2.key_check == true:
				if body.is_in_group("player1") or body.is_in_group("player2") :
					floor_1.set_layer_enabled(4,false)
					Audioplayer.play_sfx("unlock.ogg")
					key2.key_check = false
					#key.queue_free()


func _on_exit_area_body_entered(body):
	if body.is_in_group("player1") or body.is_in_group("player2"):
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_packed(next_level)
