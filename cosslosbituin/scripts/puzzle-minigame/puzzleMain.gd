extends Control
const MAIN = preload("res://dialogues/main.dialogue")

@onready var container: Node2D = $Container
@onready var player= get_node("/root/gameScene/player")


var correctPath = {
	"PuzzlePiece1": "res://assets/pieces/row-1-column-1.png",
	"PuzzlePiece2": "res://assets/pieces/row-1-column-2.png",
	"PuzzlePiece3": "res://assets/pieces/row-1-column-3.png",
	"PuzzlePiece4": "res://assets/pieces/row-2-column-1.png",
	"PuzzlePiece5": "res://assets/pieces/row-2-column-2.png",
	"PuzzlePiece6": "res://assets/pieces/row-2-column-3.png"
}

var completed := false
var minigame_scene = preload("res://scenes/puzzle.tscn")
var correct = false

func _process(delta: float) -> void:
	if !correct:
		checkPuzzle()

func checkPuzzle():
	var allcorrect = true
	
	for piece_name in correctPath.keys():
		var piece = $Container.get_node(piece_name)
		var texture_path = ""
		if piece:
			texture_path = piece.texture_rect.texture.resource_path
		if texture_path != correctPath[piece_name]:
			allcorrect = false
			break
	
	if allcorrect:
		correct = true
		print("Puzzle completed!")
		enlarge_pieces()


func enlarge_pieces():
	for piece in container.get_children():
		if piece is PanelContainer and piece.get_parent() is Node2D:
			var parent_node = piece.get_parent()
			var tween = parent_node.create_tween()
			tween.tween_property(parent_node, "scale", Vector2(1.2, 1.2), 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
			player.lock_controls()
	DialogueManager.show_dialogue_balloon(MAIN, "PuzzleEnd")
	await DialogueManager.dialogue_ended
	visible = false
	completed = true
	GlobalArray.inventory.append("puzzle")
	print(GlobalArray.inventory)
	player.unlock_controls()
	
	if GlobalArray.inventory.size() >= 4:
		player.lock_controls()
		await get_tree().create_timer(1.0).timeout
		DialogueManager.show_dialogue_balloon(MAIN, "NearEnd")
		await DialogueManager.dialogue_ended
		get_tree().change_scene_to_file("res://scenes/ending.tscn")
