extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var UINode = null
# Called when the node enters the scene tree for the first time.
func _ready():
	UINode = get_tree().get_root().find_node("CanvasForPopups",true,false)


func _on_MedicineButton_pressed():
	UINode.ShowConfirmation("MedicineAll")
	self.hide()
	

func _on_LPButton_pressed():
	UINode.ShowConfirmation("LovePotionAll")
	self.hide()
