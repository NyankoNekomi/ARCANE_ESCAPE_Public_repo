extends Node2D

@onready var sprite = $health_portion/Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_health_portion_body_entered(body):
	if body.is_in_group("player1") or body.is_in_group("player2"):
		sprite.visible= false
		await get_tree().create_timer(1.0).timeout
		queue_free()
