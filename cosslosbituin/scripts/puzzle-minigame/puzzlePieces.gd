extends PanelContainer

@onready var texture_rect: TextureRect = $TextureRect

var correct_texture : Texture = null
var snapped := false

func _ready():
	# Store initial texture as correct texture or assign it from outside
	correct_texture = texture_rect.texture

func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(get_preview())
	return texture_rect

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is TextureRect

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var temp = texture_rect.texture
	texture_rect.texture = data.texture
	data.texture = temp
	
	check_snapped()

func check_snapped():
	if texture_rect.texture == correct_texture:
		print("Correct")
		snapped = true
	else:
		print("Wrong")
		snapped = false

func get_preview():
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture_rect.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	return preview
