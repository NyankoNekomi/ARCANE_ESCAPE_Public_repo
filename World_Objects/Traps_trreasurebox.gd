extends Area2D


func _on_body_entered(body):
	if body:
		$AnimatedSprite2D.play("open")
	else:
		$AnimatedSprite2D.play ("Close")
