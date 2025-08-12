class_name Player
extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $sprite
@onready var movement: PlayerMovement = $Movement

var canMove := true


func _ready() -> void:
	movement.setReferences(sprite, animation_player)

func _process(delta: float) -> void:
	if not canMove:
		return  # Don't process movement if locked
	#Make movement
	movement.handleInput()
	if movement.updateStateAndDirection():
		movement.playAnimation()

func _physics_process(delta: float) -> void:
	if not canMove:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	velocity = movement.getVelocity()
	move_and_slide()
