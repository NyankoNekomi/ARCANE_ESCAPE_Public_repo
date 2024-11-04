extends CharacterBody2D

const MAX_SPEED = 120

@onready var sprite = $Sprite2D

@onready var collisionarea_2d = $collisionarea2d
@onready var damage_interal_timer = $DamageInteral_TIMER
var number_colliding_body:int = 0
@export var damage = 1
var current_health
@onready var healthbar = $Healthbar
@onready var point_light_2d = $PointLight2D

@onready var active_input = true

func _ready():
	current_health = $healthComponent.Maxhealth
	collisionarea_2d.body_entered.connect(on_body_entered)
	collisionarea_2d.body_exited.connect(on_body_exited)
	damage_interal_timer.timeout.connect(on_damage_interval_timeout)
	healthbar.max_value = current_health
	healthbar.value = current_health
	
	point_light_2d.visible = false
	
func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	velocity = direction * MAX_SPEED
	
	if active_input == true:
		if direction.x < 0:
			sprite.flip_h = true
		elif direction.x > 0:
			sprite.flip_h = false

		move_and_slide()
	
	toggle_light()

func toggle_light():
	
	if Input.is_action_just_pressed("detect_light_2") and point_light_2d.visible == false:
		point_light_2d.visible = true
	elif Input.is_action_just_pressed("detect_light_2") and point_light_2d.visible == true: 
		point_light_2d.visible = false
	else:
		return

func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right_2") - Input.get_action_strength("move_left_2")
	var y_movement = Input.get_action_strength("move_down_2") - Input.get_action_strength("move_up_2")
	return Vector2(x_movement, y_movement)
	
func update_health():
	healthbar.value = current_health
	
	
	
func deal_damage():
	if number_colliding_body == 0 || !damage_interal_timer.is_stopped() && current_health >= 0:
		return
	current_health= clampf(current_health - damage, 0,100)
	damage_interal_timer.start()
	update_health()
	
	if current_health <=0:
		print("gameover")
func on_body_entered(other_body):
	if other_body: 
		number_colliding_body += 1
		deal_damage()
		
	
func on_body_exited(other_body):
	if other_body: 
		number_colliding_body -=1

func on_damage_interval_timeout():
	deal_damage()


func _on_pick_hurt_area_entered(area):
	if area.name == "health_portion":
		current_health = clamp(current_health+40,0,100)
