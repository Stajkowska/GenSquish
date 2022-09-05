extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var MarketManager = null 
onready var Slime = null
onready var UINode = get_tree().get_root().find_node("CanvasForPopups",true,false)

# Called when the node enters the scene tree for the first time.
func _ready():
	MarketManager = get_tree().get_root().find_node("MarketManager",true,false)

func _on_AcceptButton_pressed():

	if (!$SlimePrice.text.is_valid_integer()):
		UINode.ShowPopUp("Please enter correct price.")
	else:
		var sold = MarketManager.SellSlime(Slime, $SlimePrice.text)
		if (sold):
			UINode.ShowPopUp("You sold your slime for " + $SlimePrice.text +"!")
			Slime.death()
			MarketManager.UpdateMoney(-(int($SlimePrice.text)))
		else:
			UINode.ShowPopUp("Your price was too high!")
			UINode.ShowSlimeOptions()
		self.hide()

func _on_CancelButton_pressed():
	UINode.ShowSlimeOptions()
	self.hide()
