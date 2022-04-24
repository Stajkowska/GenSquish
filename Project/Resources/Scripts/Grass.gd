extends Node2D

const grassEffectSc = preload("res://Scenes/Effects/GrassEffect.tscn")
const dropSc = preload("res://Scenes/Environment/Gem.tscn")

# Called when the node enters the scene tree for the first time.
func deathEffect():
	var grassEffect = grassEffectSc.instance()
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position


func drop():
	var gem = dropSc.instance()
	get_parent().add_child(gem)
	gem.global_position = global_position

func _on_HurtBox_area_entered(area):
	deathEffect()
	drop()
	queue_free()
