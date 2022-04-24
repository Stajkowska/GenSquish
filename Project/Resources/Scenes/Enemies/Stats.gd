extends Node

export(int) var maxHealth = 1 setget setMaxHP
var health = maxHealth setget setHP
var points = 0 setget setPoints

export(int) var damage = 1

signal noHP
signal changedHP(value)
signal changedMaxHP(value)
signal changedPoints(value)

func setMaxHP(value):
	maxHealth = value
	self.health = min(health, maxHealth)
	emit_signal("changedMaxHP", value)

func setHP(value):
	if(value <= maxHealth):
		health = value
		emit_signal("changedHP", value)
		if health <= 0:
			emit_signal("noHP")

func setPoints(value):
	points = value
	emit_signal("changedPoints", points)
	
	
func _ready():
	self.health = maxHealth
	
