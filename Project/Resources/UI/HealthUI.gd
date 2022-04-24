extends Control


var currentHearts = 3 setget setCurrentHearts
var hearts = 3 setget setHearts

onready var fullHearts = $HeartsFull
onready var emptyHearts = $HeartsEmpty

func setCurrentHearts(value):
	currentHearts = clamp(value,0,hearts)
	if fullHearts != null:
		fullHearts.rect_size.x = currentHearts *  15
	
func setHearts(value):
	hearts = max(value,1)
	self.currentHearts = min(currentHearts,hearts)
	if emptyHearts != null:
		emptyHearts.rect_size.x = hearts *  15
	
func _ready():
	self.hearts = PlayerStats.maxHealth
	self.currentHearts = PlayerStats.health
	PlayerStats.connect("changedHP",self,"setCurrentHearts")
	PlayerStats.connect("changedMaxHP", self, "setHearts")
