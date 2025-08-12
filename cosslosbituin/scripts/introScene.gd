extends Control


#Variables
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var rich_text_label_1: RichTextLabel = $RichTextLabel1
@onready var rich_text_label_2: RichTextLabel = $RichTextLabel2
@onready var final_text: RichTextLabel = $FinalText

#Shows what texts to play
var texts1 = {"Some things don’t fade...": Vector2(72, 72), 
		"It waits in the corner of your mind...": Vector2(176, 216),
		"And when you turn away long enough...": Vector2(264, 368)}
var texts2 = {"No matter how far you run.": Vector2(128, 144), 
		"Quiet, but heavy.": Vector2(224, 288),
		"You find it’s gone.": Vector2(320, 432)}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	final_text.visible = false
	await get_tree().create_timer(2.0).timeout
	
	var keys1 = texts1.keys()
	var keys2 = texts2.keys()
	
	for i in range(3):
		rich_text_label_1.position = texts1[keys1[i]]
		rich_text_label_2.position = texts2[keys2[i]]
		rich_text_label_1.text = keys1[i]
		rich_text_label_2.text = keys2[i]
		
		# --- First text ---
		
		rich_text_label_1.modulate.a = 1.0
		animation_player.play("textAnim1")
		await animation_player.animation_finished
		
		# --- Second text ---
		await get_tree().create_timer(1.0).timeout
		rich_text_label_2.modulate.a = 1.0
		animation_player.play("textAnim2")
		await animation_player.animation_finished
		
		# --- Pause before fade ---
		await get_tree().create_timer(0.5).timeout
		
		# --- Fade both out ---
		animation_player.play("fadeOut")
		await animation_player.animation_finished
		
	#Final Text
	await get_tree().create_timer(1).timeout
	final_text.visible = true
	await get_tree().create_timer(2).timeout
	final_text.visible = false
	# Now switch to the game
	get_tree().change_scene_to_file("res://scenes/gameScene.tscn")
		
