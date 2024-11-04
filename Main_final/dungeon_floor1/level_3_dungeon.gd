extends Node2D

const SPAWN_RADIUS = 80

@onready var vial_count_onscreen = 0
@onready var vial_scene = $player2/AbilityManager/detectionrangeabilitycontroller

@onready var game_camera_2d = $GameCamera2D
@onready var game_over = $CanvasLayer/game_over
@onready var player_1 = $Player1
@onready var player_2 = $player2

@onready var enemy_pos_2 = $area_2/enemy_pos_2
@onready var spawn_enemy_2 = $area_2/spawn_enemy2

@onready var spawn_enemy_1_timer = $area_1/spawn_enemy1
@onready var enemy_pos = $area_1/enemy_pos

@onready var enemy_pos_3 = $area_3/enemy_pos_3
@onready var spawn_enemy_3 = $area_3/spawn_enemy3


@export var rat_enemy_scene : PackedScene
@export var ghost_enemy_scene : PackedScene
@export var next_level : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	game_camera_2d.make_current()
	vial_count_onscreen = vial_scene.vial_count
	$CanvasLayer/Label.text = str(vial_count_onscreen)
	game_over.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vial_count_onscreen = vial_scene.vial_count
	$CanvasLayer/Label.text = str(vial_count_onscreen)
	
	if player_1.current_health <=0 or player_2.current_health <=0:
		Audioplayer.play_sfx("game_over.mp3")
		player_1.active_input = false
		player_2.active_input = false
		game_over.visible = true
		
		spawn_enemy_1_timer.stop()
		spawn_enemy_2.stop()
		spawn_enemy_3.stop()


func _on_area_1_enemies_body_entered(body):
	if body.is_in_group("player1") or body.is_in_group("player2"):
		spawn_enemy_1_timer.start()


func _on_spawn_enemy_1_timeout():
	var rand_direction = Vector2.RIGHT.rotated(randf_range(0,TAU))
	var spawn_position = enemy_pos.global_position + (rand_direction * SPAWN_RADIUS)
	var rat_enemy = rat_enemy_scene.instantiate()
	var ghost_enemy = ghost_enemy_scene.instantiate()
	add_child(ghost_enemy)
	add_child(rat_enemy)
	ghost_enemy.position = spawn_position
	rat_enemy.position = spawn_position + Vector2(randf_range(-20,20),randf_range(-20,20))


func _on_area_1_enemies_body_exited(body):
	spawn_enemy_1_timer.stop()


func _on_spawn_enemy_2_timeout():
	var rand_direction = Vector2.RIGHT.rotated(randf_range(0,TAU))
	var spawn_position = enemy_pos_2.global_position + (rand_direction * SPAWN_RADIUS)
	var rat_enemy = rat_enemy_scene.instantiate()
	var ghost_enemy = ghost_enemy_scene.instantiate()
	add_child(ghost_enemy)
	add_child(rat_enemy)
	ghost_enemy.position = spawn_position
	rat_enemy.position = spawn_position + Vector2(randf_range(-20,20),randf_range(-20,20))


func _on_area_2_enemies_area_entered(area):
	spawn_enemy_2.start()


func _on_area_2_enemies_area_exited(area):
	spawn_enemy_2.stop()


func _on_spawn_enemy_3_timeout():
	var rand_direction = Vector2.RIGHT.rotated(randf_range(0,TAU))
	var spawn_position = enemy_pos_3.global_position + (rand_direction * SPAWN_RADIUS)
	var rat_enemy = rat_enemy_scene.instantiate()
	var ghost_enemy = ghost_enemy_scene.instantiate()
	add_child(ghost_enemy)
	add_child(rat_enemy)
	ghost_enemy.position = spawn_position
	rat_enemy.position = spawn_position + Vector2(randf_range(-20,20),randf_range(-20,20))


func _on_area_3_enemies_area_entered(area):
	spawn_enemy_3.start()


func _on_area_3_enemies_area_exited(area):
	spawn_enemy_3.stop()


func _on_exit_area_1_body_entered(body):
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_packed(next_level)


func _on_exit_area_2_body_entered(body):
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_packed(next_level)
