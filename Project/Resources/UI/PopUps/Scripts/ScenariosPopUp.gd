extends WindowDialog


var ScenariosUnlocked = 0
onready var UINode = null
onready var Market = null
onready var Scenarios = []

onready var Genes = preload("res://Resources/Scenes/Slime/GeneManager.tscn")
onready var SlimeType = preload("res://Resources/Scenes/Slime/Slime.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	UINode = get_tree().get_root().find_node("CanvasForPopups",true,false)
	Market = get_tree().get_root().find_node("MarketManager",true,false)
	var Sc = get_tree().get_nodes_in_group("Scenario")

	for i in Sc:
		Scenarios.append(i)

	
func FinishedScenario(number):
	if (ScenariosUnlocked < number):
		match number:
			1:
				UINode.ShowPopUp("You are awarded 100 gold")
				Market.UpdateMoney(-100)
			2:
				UINode.ShowPopUp("You are awarded 1 Slime")
				var Slime1Genes = Genes.instance()
				Slime1Genes.getRandomSlimeGenes()
				var baby = SlimeType.instance()
				var SlimesInTree = get_tree().get_root().find_node("Slimes",true,false)
				SlimesInTree.add_child(baby)
				baby.spawnSlime(Slime1Genes)
			3:
				UINode.ShowPopUp("You are awarded 250 gold")
				Market.UpdateMoney(-250)
			4:
				UINode.ShowPopUp("You are awarded 250 gold")
				Market.UpdateMoney(-250)
			5:
				UINode.ShowPopUp("You are awarded 2 Slimes")
				var Slime1Genes = Genes.instance()
				var Slime2Genes = Genes.instance()
				Slime1Genes.getRandomSlimeGenes()
				Slime2Genes.getRandomSlimeGenes()
				var baby = SlimeType.instance()
				var baby2 = SlimeType.instance()
				var SlimesInTree = get_tree().get_root().find_node("Slimes",true,false)
				SlimesInTree.add_child(baby)
				SlimesInTree.add_child(baby2)
				baby.spawnSlime(Slime1Genes)
				baby2.spawnSlime(Slime2Genes)
			6:
				UINode.ShowPopUp("You are awarded 250 gold")
				Market.UpdateMoney(-250)
			7:
				UINode.ShowPopUp("You are awarded 250 gold")
				Market.UpdateMoney(-250)
			8:
				UINode.ShowPopUp("You are awarded 2 Slimes")
				var Slime1Genes = Genes.instance()
				var Slime2Genes = Genes.instance()
				Slime1Genes.getRandomSlimeGenes()
				Slime2Genes.getRandomSlimeGenes()
				var baby = SlimeType.instance()
				var baby2 = SlimeType.instance()
				var SlimesInTree = get_tree().get_root().find_node("Slimes",true,false)
				SlimesInTree.add_child(baby)
				SlimesInTree.add_child(baby2)
				baby.spawnSlime(Slime1Genes)
				baby2.spawnSlime(Slime2Genes)
			9:
				UINode.ShowPopUp("You are awarded 1000 gold")
				Market.UpdateMoney(-1000)
			10:
				UINode.ShowPopUp("You are awarded 1000 gold")
				Market.UpdateMoney(-1000)
		ScenariosUnlocked = number
		UpdateScenarios()
	
func _on_Scenario1_pressed():
	$TheBasics.visible = true
	
func _on_Scenario2_pressed():
	$Allels.visible = true

func _on_Scenario3_pressed():
	$GenotypeFenotype.visible = true
	
func _on_Scenario4_pressed():
	$TheFirstLaw.visible = true

func UpdateScenarios():
	for i in ScenariosUnlocked+1:
		print(Scenarios[i])
		Scenarios[i].disabled = false




