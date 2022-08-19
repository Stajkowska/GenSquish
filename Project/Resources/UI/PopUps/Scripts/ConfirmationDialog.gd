extends ConfirmationDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var aim = "Nothing"
onready var UINode = null
# Called when the node enters the scene tree for the first time.
func _ready():
	UINode = get_tree().get_root().find_node("CanvasForPopups",true,false)


func _on_ConfirmationDialog_confirmed():
	UINode.Confirmed(true, aim)
	aim = "Nothing"


func _on_ConfirmationDialog_hide():
	UINode.hideSelf()
