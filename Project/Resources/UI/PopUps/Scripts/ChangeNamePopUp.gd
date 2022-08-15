extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Slime = null
onready var UINode = get_tree().get_root().find_node("CanvasForPopups",true,false)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_ChangeNameButton_pressed():
	$SlimeOptionsPopUp.hide()
	$ChangeNamePopUp.NamePrep()
	$ChangeNamePopUp/ChangeName.popup_centered_ratio(0.3)
	
func _on_NameCancelButton_pressed():
	$ChangeNamePopUp/ChangeName.hide()
	$SlimeOptionsPopUp/SlimeOptions.popup_centered_ratio(0.3)
	$SlimeOptionsPopUp/SlimeOptions.updateTheSlimedata()

func _on_NameAcceptButton_pressed():
	Slime.Name = $NinePatchRect/ChangeNameLine.text
	UINode.ShowSlimeOptions()
	self.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
