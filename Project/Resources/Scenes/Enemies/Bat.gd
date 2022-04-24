extends KinematicBody2D

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO
var friction = 50
export var acceleration = 400
export var maxSpeed = 50

const enemyDeathEffectSc = preload("res://Scenes/Effects/EnemyDeathEffect.tscn")
const enemyDropSc = preload("res://Scenes/Environment/Heal.tscn")
onready var stats = $Stats
onready var detectionZone = $DetectionArea
onready var sprite = $AnimatedSprite
onready var HB = $HurtBox
onready var SC = $SoftCollision
onready var WC = $WanderController

enum {
	IDLE,
	WANDER,
	ATTACK
}

var state = IDLE

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200*delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, friction*delta)
			seekPlayer()
			if WC.getTime() == 0:
				state = randomState([IDLE, WANDER])
				WC.startTimer(rand_range(1,3))
		WANDER:
			seekPlayer()
			if WC.getTime() == 0:
				state = randomState([IDLE, WANDER])
				WC.startTimer(rand_range(1,3))
			var direction = global_position.direction_to(WC.targetP)
			velocity = velocity.move_toward(direction * maxSpeed, acceleration * delta)
			if global_position.distance_to(WC.targetP) <= 1:
				state = randomState([IDLE,WANDER])
				WC.startTimer(rand_range(1,3))
		ATTACK:
			var player = detectionZone.Player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * maxSpeed, acceleration * delta)
			else:
				state = IDLE
	sprite.flip_h = velocity.x < 0
	if SC.isColliding():
		velocity += SC.getPushed() * delta * 400
	velocity = move_and_slide(velocity)

func seekPlayer():
	if (detectionZone.canSee()):
		state = ATTACK

func randomState(stateL):
	stateL.shuffle()
	return stateL.pop_front()

func _on_HurtBox_area_entered(area):
	HB.spawnHitEffect()
	stats.health -= area.damage
	knockback = area.kVector * 180

func _on_Stats_noHP():
	queue_free()
	var enemyDeathEffect = enemyDeathEffectSc.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	var enemyDrop = enemyDropSc.instance()
	get_parent().add_child(enemyDrop)
	enemyDrop.global_position = global_position

