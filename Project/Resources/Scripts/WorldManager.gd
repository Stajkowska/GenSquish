extends Node2D

signal playerFaint
signal fadeToBlack
signal saveGame

# Called when the node enters the scene tree for the first time.
func _ready():
	#The scene is loaded for the first time. 
	#Load data from save
	#Unhide all new objects for the player
	#Set the correct time
	pass


func EndDay():
	emit_signal("playerFaint") #Player faints
	emit_signal("fadeToBlack") #Sent to DayNightCycle, so the game turns black
	emit_signal("saveGame")
	
func switchScene():
	get_tree().change_scene_to(load("res://Resources/Levels/NightScreen.tscn"))

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "Fade_to_Black"):
		switchScene()

func _on_CanvasForGUI_dayEnds():
	EndDay()

func _on_CanvasForPopups_dayEnds():
	EndDay()
	
func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"node" : "WorldManager",
	}
	return save_dict

func loadData(gameData):
	print("I loaded WM")
