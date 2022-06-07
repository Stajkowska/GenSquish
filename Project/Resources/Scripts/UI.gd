extends Control

var Slime = null

signal dayEnds

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		self.visible = false

func _on_BedSheet_body_entered(body):
	self.visible = true
	$SleepPopUp/ConfirmSleep.popup_centered_ratio(0.2)

func _on_BedSheet_body_exited(body):
	self.visible = false
	$SleepPopUp/ConfirmSleep.hide()

func _on_Player_SlimeWindow(slime):
	self.visible = true
	Slime = slime
	$SlimeOptionsPopUp.popup_centered_ratio(0.2)


func _on_GiveMedicineButton_pressed():
	Slime.gotMedicine()

func _on_GiveLPButton_pressed():
	Slime.gotLovePotion()

func _on_GiveFoodButton_pressed():
	Slime.gotFood()

func _on_ExitButton_pressed():
	self.visible = false;
	$SlimeOptionsPopUp.hide()


func _on_ConfirmSleep_confirmed():
	emit_signal("dayEnds")
