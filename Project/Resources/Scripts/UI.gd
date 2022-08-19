extends Control

var Slime = null
var activeWindow = null
var windowVisible = false
var popNodes = null
var cost = 0
var Magazine = null

signal dayEnds
signal SlimeWindow

# Called when the node enters the scene tree for the first time.
func _ready():
	popNodes = get_tree().get_nodes_in_group("PopUps")
	Magazine = get_tree().get_root().find_node("MarketManager",true,false)


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
	
func _on_CanvasForPopups_visibility_changed():
	if (self.visible):
		get_tree().paused = true
	else:
		get_tree().paused = false

func hideSelf():
	windowVisible = false
	popNodes = get_tree().get_nodes_in_group("PopUps")
	for i in popNodes:
		if (i.visible):
			windowVisible = true
	if (!windowVisible):
		self.hide()
		get_tree().paused = false

#SlimeOptions methods
func SlimeWindow(slime):
	self.show()
	Slime = slime
	$SlimeOptionsPopUp.Slime = slime
	$ChangeNamePopUp.Slime = slime
	$PriceSetPopUp.Slime = slime
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

func ShowPriceSet():
	$PriceSetPopUp.set_position(get_viewport_rect().size / 2 - $PriceSetPopUp.rect_size /2 )
	$PriceSetPopUp.show()

#Show Confirmation Window
func ShowConfirmation(aim):
	self.show()
	$ConfirmationDialog.aim = aim
	match aim:
		"Nothing":
			$ConfirmationDialog.dialog_text = "Are you sure?"
		"SellSlime":
			$ConfirmationDialog.dialog_text = "Are you sure?"
		"FeedAll":
			$ConfirmationDialog.dialog_text = "Do you want to feed all slimes?"
		"MedicineAll":
			$ConfirmationDialog.dialog_text = "Do you want to give medicine to all slimes?"
		"LovePotionAll":
			$ConfirmationDialog.dialog_text = "Do you want to give love potion to all slimes?"
	$ConfirmationDialog.set_position(get_viewport_rect().size / 2 - $PriceSetPopUp.rect_size /2 )
	$ConfirmationDialog.show()

func Confirmed(result, aim):
	match aim:
		"Nothing":
			pass
		"SellSlime":
			if (result):
				Slime.health = -100
				ShowPopUp("Your slime will be released tonight!")
			ShowSlimeOptions()
		"FeedAll":
			var Slimes = get_tree().get_nodes_in_group("Slime")
			if (Slimes.size() > Magazine.FoodAmount):
				ShowPopUp("You don't have enough Food!")
			else:
				cost = 0
				for i in Slimes:
					if (!i.getFed):
						cost += 1
					i.getFed = true
				Magazine.RemoveFood(cost)
				ShowPopUp("All your hungry slimes are fed now!")
			
		"MedicineAll":
			var Slimes = get_tree().get_nodes_in_group("Slime")
			if (Slimes.size() > Magazine.MedicineAmount):
				ShowPopUp("You don't have enough Medicine!")
			else:
				cost = 0
				for i in Slimes:
					if (!i.getMedicine):
						cost += 1
					i.getMedicine = true
				Magazine.RemoveMedicine(cost)
				ShowPopUp("All your slimes got the medicine now!")
		"LovePotionAll":
			var Slimes = get_tree().get_nodes_in_group("Slime")
			if (Slimes.size() > Magazine.LPAmount):
				ShowPopUp("You don't have enough Love Potion!")
			else:
				cost = 0
				for i in Slimes:
					if (!i.getInLove):
						cost += 1
					i.gotLovePotion()
				Magazine.RemoveLP(cost)
				ShowPopUp("All your slimes got the love potion now!")


#Show Pop Up Window
func ShowPopUp(message):
	$Popup/Message.text = message
	$Popup.popup_centered()

#ShowFood and Water Trough
func FoodWindow():
	ShowConfirmation("FeedAll")
	
func WaterWindow():
	self.show()
	$WaterPopUp.set_position(get_viewport_rect().size / 2 - $WaterPopUp.rect_size /2 )
	$WaterPopUp.show()

#Tutorial
func ShowTutorial():
	print("Tutorial")
	
#Shop
func ShowShop():
	print("SHOP")
	
#Scenarios
func ShowScenarios():
	print("Scenarios")

#show/hide operations
func _on_SleepPopUp_about_to_show():
	self.show()
func _on_SlimeOptionsPopUp_about_to_show():
	self.show()
func _on_ChangeNamePopUp_about_to_show():
	self.show()
func _on_PriceSetPopUp_about_to_show():
	self.show()
func _on_ConfirmationDialog_about_to_show():
	self.show()
func _on_SlimeOptionsPopUp_hide():
	hideSelf()
func _on_ChangeNamePopUp_hide():
	hideSelf()
func _on_PriceSetPopUp_hide():
	hideSelf()
func _on_Popup_about_to_show():
	self.show()
func _on_Popup_hide():
	hideSelf()
func _on_FoodPopUp_about_to_show():
	self.show()
func _on_FoodPopUp_hide():
	hideSelf()
func _on_WaterPopUp_about_to_show():
	self.show()
func _on_WaterPopUp_hide():
	hideSelf()
func _on_ShopPopUp_about_to_show():
	self.show()
func _on_ShopPopUp_hide():
	hideSelf()
