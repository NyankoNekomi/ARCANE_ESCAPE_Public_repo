extends Node2D



@onready var trasurebox = $Traps_trreasurebox

@onready var animatedsprite = $AnimatedSprite2D

func _on_traps_trreasurebox_body_entered(body:Node2D):
		if body.is_in_group("player_1") or body.is_in_group("player2"):
				animatedsprite.play("open")


	
	
	
