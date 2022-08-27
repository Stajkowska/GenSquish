extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TutorialPopUp_hide():
	$Page1.visible = true
	$Page2.visible = false
	$Page3.visible = false
	$Page4.visible = false


func _on_RightButton_pressed():
	$Page1.visible = false
	$Page2.visible = true


func _on_LeftButton_pressed():
	pass # Replace with function body.
