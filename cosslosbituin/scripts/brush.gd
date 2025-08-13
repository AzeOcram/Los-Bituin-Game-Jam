extends Control
@onready var player: Player = $player

const MAIN = preload("res://dialogues/main.dialogue")
var completed = false
var item_name := "brush"  # Set per minigame in Inspector

func mark_completed() -> void:
	if completed:
		return
	completed = true
	print("[DEBUG] Minigame completed:", item_name)

	await DialogueManager.dialogue_ended
	visible = false

	if item_name not in GlobalArray.inventory:
		GlobalArray.inventory.append(item_name)
	print("[DEBUG] Current inventory:", GlobalArray.inventory)

	if GlobalArray.inventory.size() >= 4:
		player.lock_controls()
		await get_tree().create_timer(1.0).timeout
		DialogueManager.show_dialogue_balloon(MAIN, "NearEnd")
		await DialogueManager.dialogue_ended
		get_tree().change_scene_to_file("res://scenes/ending.tscn")
