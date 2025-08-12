class_name Player
extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $sprite
@onready var movement: PlayerMovement = $Movement

const MAIN = preload("res://dialogues/main.dialogue")

var canInteract := false
var interactTarget : Area2D = null
var canMove := true
var isInteracting := false

func _ready() -> void:
	movement.setReferences(sprite, animation_player)

func _process(delta: float) -> void:
	if not canMove:
		return  # Don't process movement if locked
	# Make movement
	movement.handleInput()
	if movement.updateStateAndDirection():
		movement.playAnimation()

func _physics_process(delta: float) -> void:
	# movement
	if not canMove:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	velocity = movement.getVelocity()
	move_and_slide()

	if Input.is_action_just_pressed("interact"):
		if canInteract and interactTarget:
			var interactable = interactTarget.get_parent()
			if interactable.has_method("interact"):
				interactable.interact()
		else:
			print("no interact")
			# Player pressed interact but no interactable nearby
			lock_controls()
			DialogueManager.show_dialogue_balloon(MAIN, "noInteractions")
			await DialogueManager.dialogue_ended
			unlock_controls()

# Called when entering an interactable's area (Area2D)
func _on_interactable_area_entered(area: Area2D) -> void:
	canInteract = true
	interactTarget = area

# Called when leaving an interactable's area (Area2D)
func _on_interactable_area_exited(area: Area2D) -> void:
	canInteract = false
	interactTarget = null

func lock_controls():
	canMove = false
	canInteract = false
	isInteracting = true

func unlock_controls():
	canMove = true
	canInteract = true
	isInteracting = false
