extends CanvasModulate


onready var CT = $ClockTimer

var currentAnim = "DayNightCycle"
var CurrentHour = 6
var TimeRuns = true

func _ready():
	restart()
	CT.set_wait_time(10)
	CT.start()
	
func restart():
	CurrentHour = 6

func _process(delta):
	if (currentAnim == "DayNightCycle"):
		$AnimationPlayer.play("DayNightCycle")
		$AnimationPlayer.seek(CurrentHour)
		#After the time passes, it means, that it reached 24 hours and the player did not sleep.

func _on_WorldManager_fadeToBlack():
	TimeRuns = false
	CT.stop()
	currentAnim = "Fade_to_Black"
	$AnimationPlayer.play(currentAnim)

func _on_ClockTimer_timeout():
	if (TimeRuns):
		CurrentHour += 0.10
		CT.set_wait_time(10)
		CT.start()
	
