extends Control

const diag = preload("res://dialogues/character.dialogue")

var is_start = true

func _ready():
	$Exit.pressed.connect(Callable(self, "_on_exit_pressed"))


func _on_exit_pressed() -> void:
	visible = false # Replace with function body.


func _on_texture_button_pressed() -> void:
	visible = true
	
	if is_start:
		DialogueManager.show_dialogue_balloon(diag, "start")
		is_start = false
	

func _on_suspect_button_1_pressed() -> void:
	DialogueManager.show_dialogue_balloon(diag, "Rojan")


func _on_suspect_button_2_pressed() -> void:
	DialogueManager.show_dialogue_balloon(diag, "Zach")




func _on_suspect_button_3_pressed() -> void:
	DialogueManager.show_dialogue_balloon(diag, "Deyniel")
