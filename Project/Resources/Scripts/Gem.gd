extends Node2D

export (int) onready var value
var stats = PlayerStats

const sound = preload("res://UsedAssets/Effects/Video-Game-Unlock-Sound-A1-8bit-www.fesliyanstudios.com.mp3")
onready var SoundEffect = preload("res://Scenes/Effects/SoundEffect.tscn")

func _on_Area2D_body_entered(body):
	stats.points += value
	var SoundEffectSC = SoundEffect.instance()
	sound.loop = false
	SoundEffectSC.stream = sound
	SoundEffectSC.play()
	get_parent().add_child(SoundEffectSC)
	queue_free()
