extends Control


func _ready():
	self.visible =false
	
func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state=not get_tree().paused
		get_tree().paused= new_pause_state
		self.visible=new_pause_state

func _on_Restart_pressed():
	get_tree().paused=false
	get_tree().reload_current_scene()


func _on_Resume_pressed():
	self.visible=false
	get_tree().paused=false

func _on_Quit_pressed():
	get_tree().quit()


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear2db(value))
	print(value)


func _on_menuOptions_pressed():
	var new_pause_state=not get_tree().paused
	get_tree().paused= new_pause_state
	self.visible=new_pause_state


func _on_return_to_menu_pressed():
	self.visible=false
	get_tree().paused=false
