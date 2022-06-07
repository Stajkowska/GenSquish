extends KinematicBody2D


var Slime = load("res://Resources/Scenes/Slime/Slime.tscn")

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
	set_material(get_material().duplicate())
	material.set_shader_param("body_color", Genes.getBodyColour())
	
func initiate(_otherSlime, _Genes):
	Genes.inherit(_otherSlime.Genes, _Genes)
	scale.x	= Genes.getSizeGeneValue()
	scale.y	= Genes.getSizeGeneValue()
	material.set_shader_param("body_color", Genes.getBodyColour())
	position = _otherSlime.position
	global_position = _otherSlime.position
	state = IDLE
	WC.updateTarget()
	print(WC.targetP)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200*delta)
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
	velocity = move_and_slide(velocity)

func checkSlimeHealth():
	print(getFed)
	print(isSick)
	if (!getFed && !isSick):
		healthStatus = "Hungry"
		state = HUNGRY
		isSick = true
		maxSpeed = maxSpeed / 2
	elif (!getFed && isSick):
		print("Health should drop")
		print(health)
		health -= 10
		print(health)
		state = HUNGRY
		isSick = true
	elif (getFed && !isSick && health < maxHealth):
		health += 10
	if (getMedicine):
		isSick = false
		maxSpeed = maxSpeed *2
	getFed = false
	getMedicine = false
	if (health == 0):
		death()
	
func death():
	print("The Slime should die now")
	
func idle(delta):
	animationState.travel("Idle")
	velocity = velocity.move_toward(Vector2.ZERO, friction*delta)
	if WC.getTime() == 0:
		state = randomState([IDLE, WANDER])
		print("Idle normal shuffle")
		WC.startTimer(rand_range(1,3))

func wander(delta):
	var direction = global_position.direction_to(WC.targetP)
	velocity = velocity.move_toward(direction * maxSpeed, acceleration * delta)
	animationState.travel("Jump")
	if global_position.distance_to(WC.targetP) <= 1:
		state = randomState([IDLE, WANDER])
		print("Wander normal shuffle")
	
func seekPartner(delta):
	var direction = global_position.direction_to(WC.targetP)
	velocity = velocity.move_toward(direction * maxSpeed, acceleration * delta)
	animationState.travel("InLove")
	if global_position.distance_to(WC.targetP) <= 1:
		state = randomState([SEEK_PARTNER, IDLE_PARTNER])
		print("Seek Partner shuffle")
		print(state)
	var dupa = $Detection.get_overlapping_bodies() #ogarnij to
	if (dupa.is_in_group("Slime") && dupa.isInLove()):
		otherSlime = dupa
	if (otherSlime != null):
		direction = global_position.direction_to(otherSlime.position)
		velocity = velocity.move_toward(direction * maxSpeed, acceleration * delta)
		if global_position.distance_to(otherSlime.position) <= 30:
			var baby = Slime.instance()
			get_parent().add_child(baby)
			baby.initiate(otherSlime, Genes)
			state = randomState([IDLE,WANDER])
			WC.startTimer(rand_range(1,3))
			getInLove = false
			otherSlime.getInLove = false
			otherSlime = null
			
func idlePartner(delta):
	animationState.travel("InLove")
	velocity = velocity.move_toward(Vector2.ZERO, friction*delta)
	if WC.getTime() == 0:
		state = SEEK_PARTNER
		print("Idle partner shuffle")
		print(state)
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
		"node" : "Slime",
		"id" : get_instance_id(),
		"pos_x" : position.x, 
		"pos_y" : position.y,
		"healthStatus" : healthStatus,
		"health": health,
		"getFed": getFed,
		"getMedicine": getMedicine,
		"isSick": isSick
	}
	return save_dict
	
func gotMedicine():
	getMedicine = true
	
func gotLovePotion():
	if(!isSick):
		getInLove = true
		state = IDLE_PARTNER
		print("Changed state to Partner Mode")

func gotFood():
	getFed = true

func _on_InteractionRange_body_entered(body):
	if body.name == "Player":
		$EButton.visible = true
		body.interactSlime(self)


func _on_InteractionRange_body_exited(body):
	if body.name == "Player":
		$EButton.visible = false
		body.interactSlimeLeft()
		
func loadData(gameData):
	print("Called loadData on slime")
	position.x = gameData.pos_x
	position.y = gameData.pos_y
	healthStatus = gameData.healthStatus
	state = IDLE
	getFed = gameData.getFed
	isSick = gameData.isSick
	getMedicine = gameData.getMedicine
	health = gameData.health
	checkSlimeHealth()
	
func isInLove():
	return getInLove

