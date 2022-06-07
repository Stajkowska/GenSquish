extends KinematicBody2D

const friction = 700
const maxSpeed = 130
const acceleration = 500
const rollSpeed = 150

signal SlimeWindow

enum {
	MOVE,
	ROLL,
	ATTACK,
	FAINT
}
var state = MOVE

var movementVector = Vector2.ZERO
var velocity = Vector2.ZERO
var rollVector = Vector2.DOWN
var stats = PlayerStats
var slimeInReach = false
var Slime = null

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitBox = $HitBoxPivot/SwordHitBox
#onready var playerHB = $HurtBox

func _ready():
	stats.connect("noHP", self, "die")
	animationTree.active = true
	swordHitBox.kVector = movementVector

func die():
	#get_tree().reload_current_scene()
	stats.health = stats.maxHealth
	stats.points = stats.points/2

func _physics_process(delta):
	if (slimeInReach == true) && (Input.is_action_just_pressed("interact") == true) && (Slime != null):
		emit_signal("SlimeWindow", Slime)
	match state:
		MOVE:
			movement(delta)
		ATTACK:
			attack()
		ROLL:
			roll()
		FAINT:
			faint()
	
func roll():
	velocity = rollVector * rollSpeed
	animationState.travel("Roll")
	move()
	
func attack():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func movement(delta):	
	movementVector = Vector2.ZERO
	movementVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	movementVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	movementVector = movementVector.normalized()
	
	if (movementVector != Vector2.ZERO):
		rollVector = movementVector
		swordHitBox.kVector = movementVector
		animationTree.set("parameters/Idle/blend_position", movementVector)
		animationTree.set("parameters/Run/blend_position", movementVector)
		animationTree.set("parameters/Attack/blend_position", movementVector)
		animationTree.set("parameters/Roll/blend_position", movementVector)
		animationState.travel("Run")
		velocity = velocity.move_toward(movementVector*maxSpeed, acceleration*delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	if Input.is_action_just_pressed("roll"):
		state = ROLL
	
func attackAnimFinished():
	state = MOVE
	
func rollAnimFinished():
	velocity = velocity/2
	state = MOVE

func move():
	velocity = move_and_slide(velocity)

func _on_HurtBox_area_entered():
	stats.health -= 1
	#playerHB.startInv(0.5)
	#playerHB.spawnHitEffect()

func _on_WorldManager_playerFaint():
	state = FAINT
	faint()

func faint():
	animationState.travel("Idle")
	velocity = velocity.move_toward(Vector2.ZERO, friction)
	animationTree.set("parameters/Idle/blend_position", Vector2(0,1))
	
func interactSlime(slime):
	slimeInReach = true
	Slime = slime
	
func interactSlimeLeft():
	slimeInReach = false
	Slime = null
	
func save():
	var save_dict = {
		"node" : "Player",
		"pos_x" : position.x, 
		"pos_y" : position.y
	}
	return save_dict

func loadData(gameData):
	position.x = gameData.pos_x
	position.y = gameData.pos_y
