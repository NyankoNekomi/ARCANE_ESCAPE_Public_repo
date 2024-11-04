extends Area2D

class_name HurtboxComponent

@export var healthComponenet : healthComponent

func _ready():
	area_entered.connect(on_area_entered)
	
func on_area_entered (otherarea: Area2D):
	if not otherarea is hitBoxComponenet:
		return
	
	if healthComponenet == null:
		return
		
	var hitbox_compnenet = otherarea as hitBoxComponenet
	healthComponenet.damage(hitbox_compnenet.damage_given)
