extends Node2D

export(int) var wanderRange = 100
onready var startP = self.global_position
onready var targetP = self.global_position
onready var timer = $Timer

func updateTarget():
	var targetV = Vector2(rand_range(-wanderRange,wanderRange), rand_range(-wanderRange,wanderRange))
	targetP = startP + targetV

func getTime():
	return timer.time_left
	
func startTimer(amount):
	timer.start(amount)

func _on_Timer_timeout():
	updateTarget()
