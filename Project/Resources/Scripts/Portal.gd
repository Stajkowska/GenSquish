extends Node2D

export var levelName = "HomeMap"

func _on_Portal_body_entered(body):
	get_tree().change_scene("res://Scenes/Levels/" +levelName + ".tscn")
