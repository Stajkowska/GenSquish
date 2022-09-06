extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var UINode = get_tree().get_root().find_node("CanvasForPopups",true,false)
onready var Magazine = get_tree().get_root().find_node("MarketManager",true,false)
onready var Genes = preload("res://Resources/Scenes/Slime/GeneManager.tscn")
onready var SlimeType = preload("res://Resources/Scenes/Slime/Slime.tscn")
var BoughtFood = 0
var BoughtMedicine = 0
var BoughtLP = 0
var generated = false

var Slimes = []
var Prices = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_ExitButton_pressed():
	$Supplies/Information.text = ""
	BoughtFood = 0
	BoughtMedicine = 0
	BoughtLP = 0
	self.hide()


func _on_SuppliesButton_pressed():
	$ShopMenu.visible = false
	$Supplies.visible = true


func _on_SellSlimesButton_pressed():
	$ShopMenu.visible = false
	prepareSlimeCenter()
	$SlimeCenter.visible = true


func _on_BuyFood_pressed():
	if (Magazine.Money < 25):
		UINode.ShowPopUp("You don't have enough money!")
	else:
		BoughtFood += 1
		Magazine.RemoveFood(-1)
		Magazine.UpdateMoney(25)
		$Supplies/Information.text = "You have bought " + str(BoughtFood) + " slime food!"

func _on_BuyMedicine_pressed():
	if (Magazine.Money < 50):
		UINode.ShowPopUp("You don't have enough money!")
	else:
		BoughtMedicine += 1
		Magazine.RemoveMedicine(-1)
		Magazine.UpdateMoney(50)
		$Supplies/Information.text = "You have bought " + str(BoughtMedicine) + " slime medicine(s)!"

func _on_BuyLP_pressed():
	if (Magazine.Money < 100):
		UINode.ShowPopUp("You don't have enough money!")
	else:
		BoughtLP += 1
		Magazine.RemoveLP(-1)
		Magazine.UpdateMoney(100)
		$Supplies/Information.text = "You have bought " + str(BoughtLP) + " Love Potion(s)!"


func _on_ReturnButton_pressed():
	$ShopMenu.visible = true
	$SlimeCenter.visible = false
	$Supplies.visible = false

func prepareSlimeCenter():
	if (!generated):
		var group = get_tree().get_nodes_in_group("SlimeData")
		for i in group:
			var Slime1Genes = Genes.instance()
			Slime1Genes.getRandomSlimeGenes()
			Slimes.append(Slime1Genes)
			var price = Magazine.getSlimePrice(Slime1Genes)
			Prices.append(price)
			i.get_node("Slime").material.set_shader_param("body_color", Slime1Genes.getBodyColour())
			i.get_node("Description").text = str(price)	
		$SlimeCenter/Slime1Data/ColorRect4/Buy1.disabled = false
		$SlimeCenter/Slime2Data/ColorRect5/Buy2.disabled = false
		$SlimeCenter/Slime3Data/ColorRect6/Buy3.disabled = false
		$SlimeCenter/Slime4Data/ColorRect4/Buy4.disabled = false
		$SlimeCenter/Slime5Data/ColorRect5/Buy5.disabled = false
		$SlimeCenter/Slime6Data/ColorRect6/Buy6.disabled = false
		generated = true
		
	

func _on_ShopPopUp_hide():
	$ShopMenu.visible = true
	$SlimeCenter.visible = false
	$Supplies.visible = false


func _on_Buy6_pressed():
	if (checkGold(Prices[5])):
		var baby = SlimeType.instance()
		var SlimesInTree = get_tree().get_root().find_node("Slimes",true,false)
		SlimesInTree.add_child(baby)
		baby.spawnSlime(Slimes[5])
		$SlimeCenter/Slime6Data/ColorRect6/Buy6.disabled = true
		Magazine.UpdateMoney(Prices[5])
	checkSlimes()
	
func _on_Buy5_pressed():
	if (checkGold(Prices[4])):
		var baby = SlimeType.instance()
		var SlimesInTree = get_tree().get_root().find_node("Slimes",true,false)
		SlimesInTree.add_child(baby)
		baby.spawnSlime(Slimes[4])
		$SlimeCenter/Slime5Data/ColorRect5/Buy5.disabled = true
		Magazine.UpdateMoney(Prices[4])
	checkSlimes()

func _on_Buy4_pressed():
	if (checkGold(Prices[3])):
		var baby = SlimeType.instance()
		var SlimesInTree = get_tree().get_root().find_node("Slimes",true,false)
		SlimesInTree.add_child(baby)
		baby.spawnSlime(Slimes[3])
		$SlimeCenter/Slime4Data/ColorRect4/Buy4.disabled = true
		Magazine.UpdateMoney(Prices[3])
	checkSlimes()

func _on_Buy3_pressed():
	if (checkGold(Prices[2])):
		var baby = SlimeType.instance()
		var SlimesInTree = get_tree().get_root().find_node("Slimes",true,false)
		SlimesInTree.add_child(baby)
		baby.spawnSlime(Slimes[2])
		$SlimeCenter/Slime3Data/ColorRect6/Buy3.disabled = true
		Magazine.UpdateMoney(Prices[2])
	checkSlimes()

func _on_Buy2_pressed():
	if (checkGold(Prices[1])):
		var baby = SlimeType.instance()
		var SlimesInTree = get_tree().get_root().find_node("Slimes",true,false)
		SlimesInTree.add_child(baby)
		baby.spawnSlime(Slimes[1])
		$SlimeCenter/Slime2Data/ColorRect5/Buy2.disabled = true
		Magazine.UpdateMoney(Prices[1])
	checkSlimes()

func _on_Buy1_pressed():
	if (checkGold(Prices[0])):
		var baby = SlimeType.instance()
		var SlimesInTree = get_tree().get_root().find_node("Slimes",true,false)
		SlimesInTree.add_child(baby)
		baby.spawnSlime(Slimes[0])
		$SlimeCenter/Slime1Data/ColorRect4/Buy1.disabled = true
		Magazine.UpdateMoney(Prices[0])
	checkSlimes()
	
func checkGold(price):
	if (Magazine.Money < price):
		UINode.ShowPopUp("You don't have enough money!")
		return false
	else:
		return true
		
func checkSlimes():

	if ($SlimeCenter/Slime1Data/ColorRect4/Buy1.disabled && $SlimeCenter/Slime2Data/ColorRect5/Buy2.disabled 
	&& $SlimeCenter/Slime3Data/ColorRect6/Buy3.disabled && $SlimeCenter/Slime4Data/ColorRect4/Buy4.disabled
	&& $SlimeCenter/Slime5Data/ColorRect5/Buy5.disabled && $SlimeCenter/Slime6Data/ColorRect6/Buy6.disabled):
		generated = false
		prepareSlimeCenter()
		print("Prawda")
