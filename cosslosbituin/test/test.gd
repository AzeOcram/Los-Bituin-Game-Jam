extends PanelContainer

@onready var texture_rect: TextureRect = $TextureRect

func _get_drag_data(at_position: Vector2) -> Variant:
	return texture_rect

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is TextureRect

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var temp = texture_rect.texture
	texture_rect.texture = data.texture
	data.texture = temp
