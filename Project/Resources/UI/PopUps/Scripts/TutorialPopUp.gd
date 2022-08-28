extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var PageNumber = 1
onready var Pages = get_tree().get_nodes_in_group("Page")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TutorialPopUp_hide():
	hideAll()
	PageNumber = 1

func hideAll():
	Pages = get_tree().get_nodes_in_group("Page")
	for i in Pages:
		i.visible = false
	$Page1.visible = true
	

func _on_RightButton_pressed():
	PageNumber += 1
	getPageVisible()

func _on_LeftButton_pressed():
	PageNumber -= 1
	getPageVisible()
	
func getPageVisible():
	var page = $Page1
	print(PageNumber)
	if ((PageNumber > 0) && (PageNumber < 7)):
		page = Pages[PageNumber]
	else:
		page = $Page1
		PageNumber = 1
	hideAll()
	page.visible = true
