extends Control

onready var Text = $Score
var stats = PlayerStats


func _ready():
	self.visible =false

func _on_Quit_pressed():
	get_tree().quit()

func _on_Boss_endThis():
	Text.text = str(stats.points)
	var new_pause_state=not get_tree().paused
	get_tree().paused= new_pause_state
	self.visible=new_pause_state
