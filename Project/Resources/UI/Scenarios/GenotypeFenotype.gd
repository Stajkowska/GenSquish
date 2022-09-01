extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Scenarios = null
onready var UINode = null

# Called when the node enters the scene tree for the first time.
func _ready():
	UINode = get_tree().get_root().find_node("CanvasForPopups",true,false)
	Scenarios = get_tree().get_root().find_node("ScenariosPopUp",true,false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_ReturnButton_pressed():
	$Theory.visible = true
	$Excercise.visible = false
	self.visible = false


func _on_ExcersiseButton_pressed():
	$Excercise.visible = true


func _on_TheoryButton_pressed():
	$Excercise.visible = false

func _on_CheckAnswerB_pressed():
	#Quantity  0 
	#Quality - 1
	if ($Excercise/aaB.get_selected_id() == 0 &&
	$Excercise/BaB.get_selected_id() == 1 &&
	$Excercise/bbB.get_selected_id() == 2 &&
	$Excercise/ABB.get_selected_id() == 4):
		UINode.ShowPopUp("Congratulations! You unlocked another scenario.")
		$Theory.visible = true
		$Excercise.visible = false
		self.visible = false
		Scenarios.FinishedScenario(3)
	else:
		UINode.ShowPopUp("This is not correct.")
	
