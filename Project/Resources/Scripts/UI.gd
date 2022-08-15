extends Control

var Slime = null
var activeWindow = null
var windowVisible = false
var popNodes = null

signal dayEnds
signal SlimeWindow

# Called when the node enters the scene tree for the first time.
func _ready():
	popNodes = get_tree().get_nodes_in_group("PopUps")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		self.hide()
		for i in popNodes:
			i.hide()
		get_tree().paused = false


#SleepPopUp methods
func _on_BedSheet_body_entered(body):
	self.show()
	$SleepPopUp.set_position(get_viewport_rect().size / 2 - $SleepPopUp.rect_size /2 )
	$SleepPopUp.show()

func _on_BedSheet_body_exited(body):
	hideSelf()
	
func ConfirmSleep():
	emit_signal("dayEnds")

func hideSelf():
	windowVisible = false
	for i in popNodes:
		if (i.visible):
			windowVisible = true
	if (!windowVisible):
		self.hide()
		get_tree().paused = false

#SlimeOptions methods
func SlimeWindow(slime):
	self.show()
	$SlimeOptionsPopUp.Slime = slime
	$ChangeNamePopUp.Slime = slime
	$SlimeOptionsPopUp.updateTheSlimedata()
	$SlimeOptionsPopUp.set_position(get_viewport_rect().size / 2 - $SlimeOptionsPopUp.rect_size /2 )
	$SlimeOptionsPopUp.show()

func ShowChangeName():
	$ChangeNamePopUp.set_position(get_viewport_rect().size / 2 - $ChangeNamePopUp.rect_size /2 )
	$ChangeNamePopUp.show()
	
func ShowSlimeOptions():
	$SlimeOptionsPopUp.set_position(get_viewport_rect().size / 2 - $SlimeOptionsPopUp.rect_size /2 )
	$SlimeOptionsPopUp.show()
	$SlimeOptionsPopUp.updateTheSlimedata()

func _on_SleepPopUp_about_to_show():
	self.show()
func _on_SlimeOptionsPopUp_about_to_show():
	self.show()
func _on_ChangeNamePopUp_about_to_show():
	self.show()

func _on_SlimeOptionsPopUp_hide():
	hideSelf()

func _on_ChangeNamePopUp_hide():
	hideSelf()



func _on_CanvasForPopups_visibility_changed():
	if (self.visible):
		get_tree().paused = true
