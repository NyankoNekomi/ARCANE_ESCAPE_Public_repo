extends CharacterBody2D

const MAX_SPEED = 10
const max_range = 150
# Called when the node enters the scene tree for the first time.
@onready var basic_enemy = $"."


@onready var health_component = $healthComponent
@onready var visbile_hit_check = false
func _ready():
	$HurtBoxComponenet.area_entered.connect(on_area_entered)
	#$Vvisibility_box.area_entered.connect(_on_vvisibility_box_area_entered)
	#$Vvisibility_box.area_exited.connect(_on_vvisibility_box_area_exited)
	basic_enemy.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()
	
	


func get_direction_to_player():
	var player_node1 = get_tree().get_first_node_in_group("player1") as Node2D
	var player_node2 = get_tree().get_first_node_in_group("player2")as Node2D
	if player_node1 == null and player_node2 == null:
		return
	#check for the least distance
	if global_position.distance_squared_to(player_node1.global_position) < pow(max_range,2):
		return (player_node1.global_position - global_position).normalized()
	elif global_position.distance_squared_to(player_node2.global_position) < pow(max_range,2):
		return (player_node2.global_position - global_position).normalized()
	else :
		return ((player_node1.global_position +player_node2.global_position)/2).normalized()

func on_area_entered(other_area: Area2D):
	if visbile_hit_check == true and other_area.name =="HitboxComponet":
		health_component.damage(5)
		



func _on_vvisibility_box_area_entered(area_enter_player : Area2D):
	visbile_hit_check = true
	basic_enemy.visible = true


func _on_vvisibility_box_area_exited(area):
	visbile_hit_check = false
	basic_enemy.visible = false