extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Slime = null
onready var UINode = get_tree().get_root().find_node("CanvasForPopups",true,false)
onready var Magazine = get_tree().get_root().find_node("MarketManager",true,false)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_GiveLPButton_pressed():
	if (Magazine.LPAmount > 0):
		Slime.gotLovePotion()
		updateTheSlimedata()
		Magazine.RemoveLP(1)
	else:
		UINode.ShowPopUp("You don't have enough Love Potion!")
	
func _on_GiveFoodButton_pressed():
	if (Magazine.FoodAmount > 0):
		Slime.gotFood()
		updateTheSlimedata()
		Magazine.RemoveFood(1)
	else:
		UINode.ShowPopUp("You don't have enough Food!")
	
func _on_GiveMedicineButton_pressed():
	if (Magazine.MedicineAmount > 0):
		Slime.gotMedicine()
		updateTheSlimedata()
		Magazine.RemoveMedicine(1)
	else:
		UINode.ShowPopUp("You don't have enough Medicine!")

func updateTheSlimedata():
	$NinePatchRect/Age.text = str(Slime.Age) + " days old"
	$NinePatchRect/Name.text = Slime.Name
	$NinePatchRect/GiveLPButton.disabled = false
	$NinePatchRect/GiveMedicineButton.disabled = false
	$NinePatchRect/GiveFoodButton.disabled = false
	$NinePatchRect/Panel/HealthySlime.visible = false
	$NinePatchRect/Panel/IllSlime.visible = false
	$NinePatchRect/Panel/SlimeInLove.visible = false
	$NinePatchRect/Panel/SlimeInLove.material.set_shader_param("body_color", Slime.Genes.getBodyColour())
	$NinePatchRect/Panel/HealthySlime.material.set_shader_param("body_color", Slime.Genes.getBodyColour())
	$NinePatchRect/Panel/IllSlime.material.set_shader_param("body_color", Slime.Genes.getBodyColour())
	if (Slime.getInLove):
		$NinePatchRect/Status.text = "Your slime is in Love!"
		$NinePatchRect/Panel/SlimeInLove.visible = true
		$NinePatchRect/GiveLPButton.disabled = true
		$NinePatchRect/GiveFoodButton.disabled = true
		$NinePatchRect/GiveMedicineButton.disabled = true
	elif (Slime.getFed && !Slime.isSick):
		$NinePatchRect/Status.text = "Your slime is fine."
		$NinePatchRect/GiveFoodButton.disabled = true
		$NinePatchRect/Panel/HealthySlime.visible = true
		$NinePatchRect/GiveMedicineButton.disabled = true
	elif (!Slime.getFed && !Slime.isSick):
		$NinePatchRect/Status.text = "Your slime is hungry."
		$NinePatchRect/Panel/HealthySlime.visible = true
		$NinePatchRect/GiveMedicineButton.disabled = true
	elif (Slime.isSick && !Slime.getFed):
		$NinePatchRect/Status.text = "Your slime is sick and hungry."
		$NinePatchRect/Panel/IllSlime.visible = true
	elif (Slime.isSick && Slime.getFed):
		$NinePatchRect/Status.text = "Your slime is sick."
		$NinePatchRect/Panel/IllSlime.visible = true
		$NinePatchRect/GiveFoodButton.disabled = true
	else: 
		$NinePatchRect/Status.text = "Your slime is fine."
		$NinePatchRect/Panel/HealthySlime.visible = true
		

func _on_ChangeNameButton_pressed():
	UINode.ShowChangeName()
	self.hide()

func _on_ReleaseButton_pressed():
	#self.hide()
	UINode.ShowConfirmation("ReleaseSlime")
	
func _on_SellButton_pressed():
	UINode.ShowPriceSet()
	self.hide()
