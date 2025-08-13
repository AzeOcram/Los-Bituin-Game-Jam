extends StaticBody2D
const MAIN = preload("res://dialogues/main.dialogue")

func interact():
	var end_dialogue_name = str(name) + "End"
	print("[DEBUG] You interacted with:", name)

	var minigames = get_node("/root/gameScene/Minigames")

	# Hide all minigames
	for child in minigames.get_children():
		child.visible = false

	# Check if the minigame exists
	if minigames.has_node(str(name)):
		var mg = minigames.get_node(str(name))

		if mg.completed:
			DialogueManager.show_dialogue_balloon(MAIN, end_dialogue_name)
			await DialogueManager.dialogue_ended
			return

		# Play start dialogue
		DialogueManager.show_dialogue_balloon(MAIN, name)
		await DialogueManager.dialogue_ended

		mg.visible = true

		# Call the minigame's completion method
		if mg.has_method("mark_completed"):
			mg.mark_completed()
		else:
			print("[DEBUG] Minigame has no 'mark_completed' method:", name)
	else:
		print("[DEBUG] Minigame '%s' not found!" % name)
