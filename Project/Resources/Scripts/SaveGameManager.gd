extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	loadGame()

func saveGame():
	var saveGame = File.new()
	saveGame.open("./SG.save", File.WRITE)
	var savingNodes = get_tree().get_nodes_in_group("Persist")
	saveGame.store_line("Start of the file")
	for node in savingNodes:
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
		var nodeData = node.call("save")
		if nodeData != null:
			saveGame.store_line(to_json(nodeData))
	saveGame.close()
	
func loadGame():
	var saveGame = File.new()
	if not (saveGame.file_exists("./SG.save")):
		print("File doesn't exist")
		return 

	saveGame.open("./SG.save", File.READ)
	if (saveGame.get_line().empty()):
		print("File is empty")
		return
		
	var saveNodes = get_tree().get_nodes_in_group("Persist")
	for i in saveNodes:
		i.queue_free()
		
	while saveGame.get_position() < saveGame.get_len():
		var dict = {}
		var data = saveGame.get_line()
		var resultJSON = JSON.parse(data)
		var dt  = resultJSON.result
		
		var newObject = load(dt["filename"]).instance()
		get_tree().get_root().call_deferred("add_child", newObject)
		#get_node(dt["parent"]).add_child(newObject)
		newObject.loadData(dt)
		
	saveGame.close()
	print("Game loaded")


func _on_WorldManager_saveGame():
	saveGame()
