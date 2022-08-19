extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var UINode = null
onready var Magazine = null

# Called when the node enters the scene tree for the first time.
func _ready():
	UINode = get_tree().get_root().find_node("CanvasForPopups",true,false)
	Magazine = get_tree().get_root().find_node("MarketManager",true,false)

func ShowInteraction():
	$EButton.visible = true

func Interact():
	UINode.ShowPopUp("You have " + str(Magazine.MedicineAmount) + " medicine portions.")

func HideInteraction():
	$EButton.visible = false
