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
	if ($Excercise/Label3/WeightB.get_selected_id() == 0 && $Excercise/Label6/EyeCB.get_selected_id() == 1 && 
	$Excercise/Label8/NoseShapeB.get_selected_id() == 1 && $Excercise/Label9/SusceptibilityB.get_selected_id() == 0):
		UINode.ShowPopUp("Congratulations! You finished the challenge.")
		$Theory.visible = true
		$Excercise.visible = false
		self.visible = false
		Scenarios.FinishedScenario(1)
	else:
		UINode.ShowPopUp("This is not correct. Remember to read the theory carefully. You probably didn't select all possible options.")
	
