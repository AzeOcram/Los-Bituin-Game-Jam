extends Control
const MAIN = preload("res://dialogues/main.dialogue")

@onready var container: Node2D = $Container
@onready var player= get_node("/root/gameScene/player")


var correctPath = {
	"PuzzlePiece1": "res://assets/Aze-pieces/row-1-column-1.jpg",
	"PuzzlePiece2": "res://assets/Aze-pieces/row-1-column-2.jpg",
	"PuzzlePiece3": "res://assets/Aze-pieces/row-1-column-3.jpg",
	"PuzzlePiece4": "res://assets/Aze-pieces/row-2-column-1.jpg",
	"PuzzlePiece5": "res://assets/Aze-pieces/row-2-column-2.jpg",
	"PuzzlePiece6": "res://assets/Aze-pieces/row-2-column-3.jpg"
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
