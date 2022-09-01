extends Node2D


var FoodAmount = 5
var MedicineAmount = 5
var LPAmount = 5
var Money = 10
onready var UINode = get_tree().get_root().find_node("CanvasForGUI",true,false)
onready var WM = get_tree().get_root().find_node("WorldManager",true,false)


# Called when the node enters the scene tree for the first time.
func _ready():
	UpdateMoney(0)

func SellSlime(slime, price):
	var proposedPrice = getSlimePrice(slime.Genes)
	if (price > proposedPrice+40):
		return false
	else:
		return true

func RemoveFood(cost):
	FoodAmount -= cost
func RemoveMedicine(cost):
	MedicineAmount -= cost
func RemoveLP(cost):
	LPAmount -= cost
	
func UpdateMoney(cost):
	Money -= cost
	UINode.UpdateMoney(Money)
	
func getSlimePrice(SlimeGenes):
	var cost = 0
	
	var bodyColour = SlimeGenes.getBodyColour()
	if (bodyColour.is_equal_approx(Color("#c72424"))):
		cost += 50
	elif (bodyColour.is_equal_approx(Color("#dbd221"))):
		cost += 40
	elif (bodyColour.is_equal_approx(Color("#1ed69f"))):
		cost += 30
	elif (bodyColour.is_equal_approx(Color("#8a27cc"))):
		cost += 20
	elif (bodyColour.is_equal_approx(Color("#e6e6e6"))):
		cost += 10
	else:
		cost += 5
	
	var sizeGeneDictionary = {"aa": 3.0, "bb": 4.0, "AA": 3.5, "BB": 2.0, "Aa": 3.5, "Bb": 2.0, 
							"ab": 3.5, "aB": 2.0, "bA": 3.5, "AB":2.7, "ba": 3.5, "aA": 3.5, "bB": 2.0, "Ba": 2.0, "Ab": 3.5}
	
	var sizeGeneV = SlimeGenes.getSizeGeneValue()
	if (sizeGeneV == 4.0):
		cost += 50
	elif (sizeGeneV == 2.0):
		cost += 90
	else:
		cost += 5
	
	return cost
