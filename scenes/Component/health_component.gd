extends Node

class_name healthComponent
signal died

@export var Maxhealth : float = 10
@onready var current_health : float = Maxhealth

func _ready():
	current_health = Maxhealth

func damage(damage_amount: float):
	current_health = minf(current_health - damage_amount, 0)
	if current_health <= 0:
		emit_signal("died")
		owner.queue_free()
