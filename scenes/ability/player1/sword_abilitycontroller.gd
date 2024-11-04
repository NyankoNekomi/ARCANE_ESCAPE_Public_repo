extends Node

@export var sword_ability :PackedScene
@export var Max_dist = 50
@onready var damage = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("Timer")
	#$Timer.timeout.connect(_on_timer_timeout)
	pass
func _input(event):
	if Input.get_action_strength("attack_player1"):
		activate_sword_ability()

# Function to activate the sword ability.
func activate_sword_ability():
	var enemies = get_tree().get_nodes_in_group("enemy")
	var player = get_tree().get_first_node_in_group("player1") as Node2D
	# Check if player is there or not.
	if player == null:
		return
	
	var sword_instance = sword_ability.instantiate() as SwordAbility
	player.get_parent().add_child(sword_instance)
	sword_instance.hitbox_component.damage_given = damage
	if enemies.size() > 0:
		sword_instance.global_position = enemies[0].global_position
		Audioplayer.play_sfx("short-woosh.wav")
	else:
		sword_instance.global_position = player.global_position
		Audioplayer.play_sfx("short-woosh.wav")
	


#timer for timeout signal
#func _on_timer_timeout():
	#var player1 = get_tree().get_first_node_in_group("player1") as Node2D
	##check if player is there or not
	#if player1 == null:
		#return
	#
	#
	#
	#
	#var sword_instance = sword_ability.instantiate() as Node2D
	#player1.get_parent().add_child(sword_instance)
	#sword_instance.global_position = player1.global_position
