class_name Player
extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $sprite
@onready var movement: PlayerMovement = $Movement


func _ready() -> void:
	movement.setReferences(sprite, animation_player)

func _process(delta: float) -> void:
	#Make movement
	movement.handleInput()
	if movement.updateStateAndDirection():
		movement.playAnimation()

func _physics_process(delta: float) -> void:
	#Determine velocity
	velocity = movement.getVelocity()
	move_and_slide()
