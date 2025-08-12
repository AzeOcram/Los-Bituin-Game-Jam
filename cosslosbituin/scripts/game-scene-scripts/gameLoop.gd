extends Node2D

# Dialogues
const MAIN = preload("res://dialogues/main.dialogue")

@onready var player: Player = $player

func _ready() -> void:
	startIntro()

func startIntro() -> void:
	player.canMove = false
	await get_tree().create_timer(1.0).timeout
	DialogueManager.show_dialogue_balloon(MAIN, "start")
	await DialogueManager.dialogue_ended
	player.canMove = true
