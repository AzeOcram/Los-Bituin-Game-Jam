class_name PlayerMovement
extends Node

# --- Constants ---
const SPEED = 200.0

enum charState { IDLE, WALK }
enum charDirection { DOWN, UP, LEFT, RIGHT }

# --- Variables ---
var state: charState = charState.IDLE
var cardinalDirection: charDirection = charDirection.DOWN
var direction := Vector2.ZERO

# References (set from Player.gd)
var sprite: Sprite2D
var animation_player: AnimationPlayer

# --- Set references from outside ---
func setReferences(p_sprite: Sprite2D, p_animation_player: AnimationPlayer) -> void:
	sprite = p_sprite
	animation_player = p_animation_player

# --- Handle input ---
func handleInput() -> void:
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = direction.normalized() if direction != Vector2.ZERO else Vector2.ZERO

# --- Update state & direction ---
func updateStateAndDirection() -> bool:
	var changed := false

	# --- State ---
	var newState = charState.IDLE if direction == Vector2.ZERO else charState.WALK
	if newState != state:
		state = newState
		changed = true

	# --- Direction ---
	if direction != Vector2.ZERO:
		var newDirection = cardinalDirection
		if abs(direction.x) > abs(direction.y):
			newDirection = charDirection.LEFT if direction.x < 0 else charDirection.RIGHT
		else:
			newDirection = charDirection.UP if direction.y < 0 else charDirection.DOWN

		if newDirection != cardinalDirection:
			cardinalDirection = newDirection
			if sprite:
				sprite.scale.x = -1 if cardinalDirection == charDirection.LEFT else 1
			changed = true

	return changed

# --- Play animation ---
func playAnimation() -> void:
	if animation_player:
		animation_player.play("%s_%s" % [stateToString(), dirToString()])

# --- Convert state to string ---
func stateToString() -> String:
	match state:
		charState.IDLE: return "idle"
		charState.WALK: return "walk"
		_: return "idle"

# --- Convert direction to string ---
func dirToString() -> String:
	match cardinalDirection:
		charDirection.DOWN: return "down"
		charDirection.UP: return "up"
		_: return "side"

# --- Get current velocity ---
func getVelocity() -> Vector2:
	return direction * SPEED
