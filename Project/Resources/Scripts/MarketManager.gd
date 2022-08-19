extends Node2D


var FoodAmount = null
var MedicineAmount = null
var LPAmount = null



# Called when the node enters the scene tree for the first time.
func _ready():
	FoodAmount = 5
	MedicineAmount = 5
	LPAmount = 5 


func SellSlime(slime, price):
	print("I got the data")

func RemoveFood(cost):
	FoodAmount -= cost
func RemoveMedicine(cost):
	MedicineAmount -= cost
func RemoveLP(cost):
	LPAmount -= cost

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"node" : "MartketManager",
		"FoodAmount": FoodAmount,
		"MedicineAmount": MedicineAmount,
		"LPAMount": LPAmount
	}
	return save_dict

func loadData(gameData):
	FoodAmount = gameData.FoodAmount
	MedicineAmount = gameData.MedicineAmount
	LPAmount = gameData.LPAmount 
