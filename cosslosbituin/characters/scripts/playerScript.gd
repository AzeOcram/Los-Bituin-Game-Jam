class_name Player
extends CharacterBody2D

var cardinalDirection := Vector2.DOWN
var direction := Vector2.ZERO
var speed = 150.0
var state: String = "idle"


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $sprite

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	# Directions
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity = direction * speed
	
	#Set state
	if setState() == true || setDirection() == true:
		updateAnimation()
		

func _physics_process(delta: float) -> void:
	move_and_slide()

func setState() -> bool:
	var newState : String = "idle" if direction == Vector2.ZERO else "walk"
	
	if newState == state:
		return false
	
	state = newState
	
	return true

func setDirection() -> bool:
	var newDirection: Vector2 = cardinalDirection
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		newDirection = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		newDirection = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if newDirection == cardinalDirection:
		return false
	
	cardinalDirection = newDirection
	sprite.scale.x = -1 if cardinalDirection == Vector2.LEFT else 1
	
	return true

func updateAnimation() -> void:
	animation_player.play(state + "_" + animDirection())

func animDirection() -> String:
	if cardinalDirection == Vector2.DOWN:
		return "down"
	elif cardinalDirection == Vector2.UP:
		return "up"
	else:
		return "side"
