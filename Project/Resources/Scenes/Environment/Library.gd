extends StaticBody2D


onready var UINode = null

# Called when the node enters the scene tree for the first time.
func _ready():
	UINode = get_tree().get_root().find_node("CanvasForPopups",true,false)

func ShowInteraction():
	$EButton.visible = true

func Interact():
	UINode.ShowScenarios()

func HideInteraction():
	$EButton.visible = false
