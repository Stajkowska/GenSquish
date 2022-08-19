extends ConfirmationDialog


# Declare member variables here. Examples:
# var a = 2
onready var UINode = get_tree().get_root().find_node("CanvasForPopups",true,false)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_ConfirmSleep_confirmed():
	UINode.ConfirmSleep()


func _on_ConfirmSleep_popup_hide():
	UINode.hideSelf()
	

func _on_ConfirmSleep_hide():
	UINode.hideSelf()
