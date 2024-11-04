extends Area2D

@onready var key_check = false



func _on_body_entered(body:Node2D):
	if body.is_in_group("player2"):
		$AnimatedSprite2D.visible = false
		key_check = true
		Audioplayer.play_sfx("key_pick")
		
