extends Area2D

const hitEffect = preload("res://Resources/Effects/HitEffect.tscn")

onready var timer = $Timer

var invincible = false setget setInv

signal invStart
signal invEnd

func setInv(value):
	invincible = value
	if invincible == true:
		emit_signal("invStart")
	else:
		emit_signal("invEnd")

func startInv(duration):
	self.invincible = true
	timer.start(duration)

func spawnHitEffect():
	var effect = hitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position


func _on_Timer_timeout():
	self.invincible = false


func _on_HurtBox_invStart():
	set_deferred("monitorable",false)


func _on_HurtBox_invEnd():
	set_deferred("monitorable", true)
