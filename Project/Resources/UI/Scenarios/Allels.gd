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
	if ($Excercise/Label3/AA.get_selected_id() == 1 &&
	$Excercise/Label6/Aa.get_selected_id() == 0 &&
	$Excercise/Label7/aa.get_selected_id() == 2 &&
	$Excercise/Label8/Ba.get_selected_id() == 0 &&
	$Excercise/Label9/AB.get_selected_id() == 1):
		UINode.ShowPopUp("Congratulations! You unlocked the next challenge.")
		$Theory.visible = true
		$Excercise.visible = false
		self.visible = false
		Scenarios.FinishedScenario(2)
	else:
		UINode.ShowPopUp("This is not correct. Remember to read the theory carefully.")
	
