extends RichTextLabel

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("textFade")
	await animation_player.animation_finished
	await get_tree().create_timer(0.5).timeout
	visible = false
	text = "It was a horrible nightmare"
	visible = true
	animation_player.play("textFade")
	await animation_player.animation_finished
	await get_tree().create_timer(0.5).timeout
	visible = false
	text = "There was a version of me. Full of joy and hope to become an artist"
	visible = true
	animation_player.play("textFade")
	await animation_player.animation_finished
	await get_tree().create_timer(0.5).timeout
	visible = false
	text = "But everyone treats that version of me so bad"
	visible = true
	animation_player.play("textFade")
	await animation_player.animation_finished
	await get_tree().create_timer(0.5).timeout
	visible = false
	text = "Eventually, i killed it."
	visible = true
	animation_player.play("textFade")
	await animation_player.animation_finished
	await get_tree().create_timer(0.5).timeout
	visible = false
	text = "MONOCHROMATIC"
	visible = true
	await get_tree().create_timer(10).timeout
	get_tree().change_scene_to_file("res://scenes/intro_scene.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
