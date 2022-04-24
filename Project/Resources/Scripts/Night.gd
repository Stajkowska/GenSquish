extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	#Show summary of the prev day
	#Show sold slimes
	#Show how many were bred
	#Show the debt
	
	#Load the map back
	switchScene()
	
func switchScene():
	get_tree().change_scene_to(load("res://Resources/Levels/Home.tscn"));

