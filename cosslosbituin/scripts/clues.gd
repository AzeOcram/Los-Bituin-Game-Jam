extends StaticBody2D
const MAIN = preload("res://dialogues/main.dialogue")


func interact():
	var endDialogueName = str(name) + "End"
	print("You interacted with:", name)
	print(endDialogueName)
	#get the minigames parent node
	var minigames = get_node("/root/gameScene/Minigames")
	
	#hide all minigames
	for child in minigames.get_children():
		child.visible = false
	
	#Select which minigame to show
	var node_path = NodePath(name)
	if minigames.has_node(node_path):
		if minigames.get_node(node_path).completed:
			DialogueManager.show_dialogue_balloon(MAIN, endDialogueName)
			return
		DialogueManager.show_dialogue_balloon(MAIN, name)
		await DialogueManager.dialogue_ended
		minigames.get_node(node_path).visible = true
	else:
		print("Minigame '%s' not found!" % name)
