extends Node2D

func _ready():
	pass
	

func _on_player_body_entered(otherbody:CharacterBody2D):
	if otherbody.is_in_group("player1") or otherbody.is_in_group("player2"):
		GameEvents.emit_increment_vial_collected(1)
		Audioplayer.play_sfx("coin.wav")
		queue_free()
	
	
