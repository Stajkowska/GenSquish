extends Button

export(String) var refPath = ""
export(bool) var startFocused = false

func _ready():
	if(startFocused):
		grab_focus()
	connect("mouse_entered", self, "_on_Button_mouse_entered")
	connect("pressed", self, "_on_Button_Pressed")

func _on_Button_mouse_entered():
	grab_focus()
	
func _on_Button_Pressed():
	if (refPath != ""):
		get_tree().change_scene(refPath)
	else:
		get_tree().quit()
