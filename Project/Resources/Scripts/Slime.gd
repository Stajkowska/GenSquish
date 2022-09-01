extends KinematicBody2D


var Slime = load("res://Resources/Scenes/Slime/Slime.tscn")
onready var OGenes = preload("res://Resources/Scenes/Slime/GeneManager.tscn")

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO
var friction = 50
var health = 30
var maxHealth = 30
var healthStatus = "Healthy"
var otherSlime = null

var getFed = false
var getInLove = false
var isSick = false
var getMedicine = false
var UINode = null
var Name = "Nameless"
var Age = 0
var GN = null
export var birth = false
export var acceleration = 400
export var maxSpeed = 50

const enemyDeathEffectSc = preload("res://Resources/Effects/EnemyDeathEffect.tscn")
const enemyDropSc = preload("res://Resources/Scenes/Environment/Heal.tscn")

onready var stats = $Stats
onready var Genes = $GeneManager
#onready var detectionZone = $DetectionArea
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var sprite = $Slime
#onready var SC = $SoftCollision
onready var WC = $WanderController
onready var EButton = $EButton
onready var SC = $SoftCollision
onready var T = $Timer

enum {
	IDLE,
	WANDER,
	SEEK_PARTNER,
	HUNGRY,
	HUNGRY_WANDER,
	IDLE_PARTNER
}

var state = IDLE

func _ready():
	UINode = get_tree().get_root().find_node("CanvasForPopups",true,false)
	set_material(get_material().duplicate())
	material.set_shader_param("body_color", Genes.getBodyColour())
	if (GN != null):
		Genes.setGenes(GN)
	scale.x	= Genes.getSizeGeneValue()
	scale.y	= Genes.getSizeGeneValue()
	add_to_group("Persist", true)
	add_to_group("Interactable", true)
	T.start(1200) #start timer for 20 minutes

func spawnSlime(_Genes):
	add_to_group("Persist", true)
	add_to_group("Interactable", true)
	Genes.setGenes(_Genes)
	scale.x	= Genes.getSizeGeneValue()
	scale.y	= Genes.getSizeGeneValue()
	material.set_shader_param("body_color", Genes.getBodyColour())
	var spawnPoint = get_parent()
	position = spawnPoint.position
	global_position = spawnPoint.position
	state = IDLE
	
func initiate(_otherSlime, _Genes):
	add_to_group("Persist", true)
	add_to_group("Interactable", true)
	Genes.inherit(_otherSlime.Genes, _Genes)
	scale.x	= Genes.getSizeGeneValue()
	scale.y	= Genes.getSizeGeneValue()
	material.set_shader_param("body_color", Genes.getBodyColour())
	var spawnPoint = get_parent()
	position = spawnPoint.position
	global_position = spawnPoint.position
	state = IDLE

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, delta)
	knockback = move_and_slide(knockback)
	
	animationState.travel("Idle")
	match state:
		IDLE:
			idle(delta)
		WANDER:
			wander(delta)
		SEEK_PARTNER:
			seekPartner(delta)
		IDLE_PARTNER:
			idlePartner(delta)
		HUNGRY:
			hungry(delta)
		HUNGRY_WANDER:
			hungryWander(delta)
	sprite.flip_h = velocity.x < 0
	if SC.isColliding():
		velocity += SC.getPushed() * delta * 90
	velocity = move_and_slide(velocity)

func checkSlimeHealth():
	if (!getFed && !isSick):
		healthStatus = "Hungry"
		state = HUNGRY
		isSick = true
		maxSpeed = maxSpeed / 2
	elif (!getFed && isSick):
		health -= 10
		state = HUNGRY
		isSick = true
	elif (getFed && !isSick && health < maxHealth):
		health += 10
	if (getMedicine):
		isSick = false
		maxSpeed = maxSpeed *2
	getFed = false
	getMedicine = false
	if (health <= 0):
		death()
	
func death():
	print("The Slime should die now")
	queue_free()
	
func idle(delta):
	animationState.travel("Idle")
	velocity = velocity.move_toward(Vector2.ZERO, friction*delta)
	if WC.getTime() == 0:
		state = randomState([IDLE, WANDER])
		WC.startTimer(rand_range(1,3))

func wander(delta):
	var direction = global_position.direction_to(WC.targetP)
	velocity = velocity.move_toward(direction * maxSpeed, acceleration * delta)
	animationState.travel("Jump")
	if global_position.distance_to(WC.targetP) <= 1:
		state = randomState([IDLE, WANDER])
	
func seekPartner(delta):
	var direction = position.direction_to(WC.targetP)
	velocity = velocity.move_toward(direction * maxSpeed, acceleration * delta)
	animationState.travel("InLove")
	if global_position.distance_to(WC.targetP) <= 1:
		state = randomState([SEEK_PARTNER, IDLE_PARTNER])
	var bodies = $Detection.get_overlapping_bodies() #ogarnij to
	for body in bodies:
		if (body.is_in_group("Slime") && body.isInLove()) && body != self:
			otherSlime = body
	if (otherSlime != null):
		direction = position.direction_to(otherSlime.position)
		velocity = velocity.move_toward(direction * maxSpeed, acceleration * delta)
		if position.distance_to(otherSlime.position) <= 50:
			otherSlime.getInLove = false
			getInLove = false
			var baby = Slime.instance()
			get_parent().add_child(baby)
			baby.initiate(otherSlime, Genes)
			otherSlime.state = randomState([IDLE,WANDER])
			state = randomState([IDLE,WANDER])
			WC.startTimer(rand_range(1,3))
			otherSlime = null
			
func idlePartner(delta):
	animationState.travel("InLove")
	velocity = velocity.move_toward(Vector2.ZERO, friction*delta)
	if WC.getTime() == 0:
		state = SEEK_PARTNER
		WC.startTimer(rand_range(1,3))

func hungry(delta):
	animationState.travel("Hungry")
	velocity = velocity.move_toward(Vector2.ZERO, friction*delta)
	if WC.getTime() == 0:
		state = randomState([HUNGRY, HUNGRY_WANDER])
	
func hungryWander(delta):
	WC.startTimer(rand_range(5,7))
	if WC.getTime() == 0:
		state = randomState([IDLE, WANDER])
	var direction = global_position.direction_to(WC.targetP)
	velocity = velocity.move_toward(direction * maxSpeed, acceleration * delta)
	animationState.travel("HungryJump")
	if global_position.distance_to(WC.targetP) <= 1:
		state = randomState([HUNGRY, HUNGRY_WANDER])
		WC.startTimer(rand_range(5,7))
	
func randomState(stateL):
	stateL.shuffle()
	return stateL.pop_front()
	
func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"node" : "Slime",
		"id" : get_instance_id(),
		"pos_x" : global_position.x, 
		"pos_y" : global_position.y,
		"healthStatus" : healthStatus,
		"health": health,
		"getFed": getFed,
		"getMedicine": getMedicine,
		"isSick": isSick,
		"name": Name,
		"age": Age,
		"SizeGene" : Genes.sizeGene,
		"BodyColourGene" : Genes.bodyColourGene,
		"EyeColourGene" : Genes.eyeColourGene
	}
	return save_dict
	
func gotMedicine():
	getMedicine = true
	
func gotLovePotion():
	if(!isSick):
		getInLove = true
		state = IDLE_PARTNER

func gotFood():
	getFed = true
	
func loadData(gameData):
	global_position.x = gameData.pos_x
	global_position.y = gameData.pos_y
	healthStatus = gameData.healthStatus
	state = IDLE
	getFed = gameData.getFed
	isSick = gameData.isSick
	getMedicine = gameData.getMedicine
	health = gameData.health
	Name = gameData.name
	Age = gameData.age
	checkSlimeHealth()
	var OGenes = preload("res://Resources/Scenes/Slime/GeneManager.tscn")
	GN = OGenes.instance()
	GN.sizeGene = gameData.SizeGene
	GN.bodyColourGene = gameData.BodyColourGene
	GN.eyeColourGene = gameData.EyeColourGene

	
func isInLove():
	return getInLove

func ShowInteraction():
	EButton.visible = true

func Interact():
	UINode.SlimeWindow(self)

func HideInteraction():
	EButton.visible = false
	
func gotSold():
	death()


func _on_Timer_timeout():
	checkSlimeHealth()
	T.start(1200)
