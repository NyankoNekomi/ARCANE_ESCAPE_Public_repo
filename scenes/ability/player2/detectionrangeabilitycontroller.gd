extends Node

@export var attack :PackedScene
@export var hidden_enemy_detect :PackedScene
@export var max_range = 200


@onready var player = get_tree().get_first_node_in_group("player2") as Node2D
@onready var pointer :Node2D = $"../../Arrow_pointer"
@onready var vial_count
@export var damage = 2
func _ready():
	vial_count = $VialXP_manager.current_xp_collected
	damage = 100
	
func _process(delta):
	vial_count = $VialXP_manager.current_xp_collected
	if Input.is_action_pressed("attack_player2") and vial_count > 0:
		attact_enemy()
	

func activate_enemy_detection():
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func (enemy : Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(max_range,2))

	if player == null:
		return

	enemies.sort_custom(func (a: Node2D,b: Node2D):
		var a_dist = a.global_position.distance_squared_to(player.global_position)
		var b_dist = b.global_position.distance_squared_to(player.global_position)
		return a_dist < b_dist
	)

	if enemies.size() != 0:
		pointer.global_position = player.global_position + Vector2(5,0)
		var direction : Vector2 = (enemies[0].global_position - player.global_position).normalized()
		var angle = deg_to_rad(direction.angle())
		pointer.rotate(-angle)
	else:
		pointer.rotation = 0


func attact_enemy():
		
		# Activate player ability here
		var enemies = get_tree().get_nodes_in_group("enemy")
		enemies = enemies.filter(func (enemy : Node2D):
			return enemy.global_position.distance_squared_to(player.global_position) < pow(max_range,2))

		if enemies.size() != 0:
				var fire_burn_detect = attack.instantiate() as SpellAbility
				player.get_parent().add_child(fire_burn_detect)
				fire_burn_detect.hitbox_component.damage_given = damage
				fire_burn_detect.global_position = enemies[0].global_position
				GameEvents.emit_spend_vial(1)
				Audioplayer.play_sfx("spell.mp3")
				
				
				
