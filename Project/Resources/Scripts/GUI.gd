extends Control


var hour = 6
var minute = 0

signal dayEnds

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ClockTimer_timeout():
	minute += 1
	if (minute > 6):
		minute = 0
		hour += 1
	if (hour > 23):
		emit_signal("dayEnds")
		hour = 24
		minute = 0
	if (hour < 10):
		$TimePanel/TimeLabel.text = "0" + String(hour) + ":" + String(minute) + "0"
	else:
		$TimePanel/TimeLabel.text = String(hour) + ":" + String(minute) + "0"
	

