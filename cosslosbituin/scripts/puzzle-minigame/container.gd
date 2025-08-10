extends Node2D


func _ready() -> void:
	randomize_textures()

func randomize_textures():
	var children = get_children()
	
	# Collect all textures from children
	var textures = []
	for child in children:
		if child is PanelContainer:
			var tex_rect = child.get_node_or_null("TextureRect")
			if tex_rect and tex_rect.texture:
				textures.append(tex_rect.texture)
	
	# Shuffle textures array
	textures.shuffle()
	
	# Assign shuffled textures back to children
	var idx = 0
	for child in children:
		if child is PanelContainer:
			var tex_rect = child.get_node_or_null("TextureRect")
			if tex_rect:
				tex_rect.texture = textures[idx]
				idx += 1
