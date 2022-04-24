extends Area2D

var Player = null


func canSee():
	return Player != null

func _on_DetectionArea_body_entered(body):
	Player = body

func _on_DetectionArea_body_exited(body):
	Player = null
