extends Node2D

signal playerFaint
signal fadeToBlack
signal saveGame

onready var Market
onready var Scenarios
onready var UI

# Called when the node enters the scene tree for the first time.
func _ready():
	#The scene is loaded for the first time. 
	#Load data from save
	#Unhide all new objects for the player
	#Set the correct time
	UI = get_tree().get_root().find_node("CanvasForPopups",true,false)
	Market = get_tree().get_root().find_node("MarketManager",true,false)
	Scenarios = get_tree().get_root().find_node("ScenariosPopUp",true,false)
	UI.ShowPopUp("Welcome to GenSquish! Check out your house, breed slimes and complete challenges!")



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
	print("Dostałem")
	EndDay()
	
func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"node" : "WorldManager",
		"Money" : Market.Money,
		"ScenariosUnlocked" : Scenarios.ScenariosUnlocked,
		"FoodAmount": Market.FoodAmount,
		"MedicineAmount": Market.MedicineAmount,
		"LPAMount": Market.LPAmount
	}
	return save_dict

func loadData(gameData):
	#Market.Money = gameData.Money
	#Market.UpdateMoney(0)
	#Scenarios.ScenariosUnlocked = gameData.ScenariosUnlocked
	#Market.FoodAmount = gameData.FoodAmount
	#Market.MedicineAmount = gameData.MedicineAmount
	#Market.LPAmount = gameData.LPAmount 
	pass
	
