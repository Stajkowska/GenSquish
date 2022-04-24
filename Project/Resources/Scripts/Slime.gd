extends KinematicBody2D

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO
var friction = 50
var status = "Healthy"

export var acceleration = 400
export var maxSpeed = 50

const enemyDeathEffectSc = preload("res://Resources/Effects/EnemyDeathEffect.tscn")
const enemyDropSc = preload("res://Resources/Scenes/Environment/Heal.tscn")

onready var stats = $Stats
#onready var detectionZone = $DetectionArea
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var sprite = $Slime
#onready var SC = $SoftCollision
onready var WC = $WanderController

enum {
	Healthy,
	Ill,
	InLove
}

enum {
	IDLE,
	WANDER
}

var state = IDLE

func _ready():
	pass

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200*delta)
	knockback = move_and_slide(knockback)
	animationState.travel("Idle")
	match state:
		IDLE:
			animationState.travel("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, friction*delta)
			if WC.getTime() == 0:
				state = randomState([IDLE, WANDER])
				WC.startTimer(rand_range(1,3))
		WANDER:
			if WC.getTime() == 0:
				state = randomState([IDLE, WANDER])
				WC.startTimer(rand_range(1,3))
			var direction = global_position.direction_to(WC.targetP)
			velocity = velocity.move_toward(direction * maxSpeed, acceleration * delta)
			animationState.travel("Jump")
			if global_position.distance_to(WC.targetP) <= 1:
				state = randomState([IDLE,WANDER])
				WC.startTimer(rand_range(1,3))

	sprite.flip_h = velocity.x < 0
	#if SC.isColliding():
	#	velocity += SC.getPushed() * delta * 400
	velocity = move_and_slide(velocity)


func randomState(stateL):
	stateL.shuffle()
	return stateL.pop_front()
	
func save():
	var save_dict = {
		"node" : "Slime",
		"id" : get_instance_id(),
		"pos_x" : position.x, 
		"pos_y" : position.y,
		"status" : status,
		"state" : state,
	}
	return save_dict


func _on_InteractionRange_body_entered(body):
	if body.name == "Player":
		$EButton.visible = true
		body.interactSlime(self)


func _on_InteractionRange_body_exited(body):
	if body.name == "Player":
		$EButton.visible = false
		body.interactSlimeLeft(self)
		
func loadData(gameData):
	position.x = gameData.pos_x
	position.y = gameData.pos_y
	status = gameData.status
	state = gameData.state


