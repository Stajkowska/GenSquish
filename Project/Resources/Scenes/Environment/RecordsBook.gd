extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func ShowInteraction():
	$EButton.visible = true

func Interact():
	print("Record")

func HideInteraction():
	$EButton.visible = false
