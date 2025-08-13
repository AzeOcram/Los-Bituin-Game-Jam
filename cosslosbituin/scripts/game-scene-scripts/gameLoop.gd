extends Node2D

# Dialogues
const MAIN = preload("res://dialogues/main.dialogue")

@onready var player: Player = $player
@onready var timer: Timer = $"Timer UI/Timer"


func _ready() -> void:
	startIntro()

#func _process(delta: float) -> void:
	#if len(GlobalArray.inventory) >= 4:
		#checkLastScene()

func startIntro() -> void:
	player.lock_controls()
	await get_tree().create_timer(1.0).timeout
	DialogueManager.show_dialogue_balloon(MAIN, "start")
	await DialogueManager.dialogue_ended
	player.unlock_controls()

func checkLastScene () -> void:
	await get_tree().create_timer(1.0).timeout
	DialogueManager.show_dialogue_balloon(MAIN, "NearEnd")
	await DialogueManager.dialogue_ended
	get_tree().change_scene_to_file("res://scenes/ending.tscn")
