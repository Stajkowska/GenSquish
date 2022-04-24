extends Control

var currentPoints = 0

onready var text = $Text

func addValue(value):
	currentPoints = value
	text.text = String(currentPoints)
	
func _ready():
	self.currentPoints = PlayerStats.points
	PlayerStats.connect("changedPoints",self,"addValue")

