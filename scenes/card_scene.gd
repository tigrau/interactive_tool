extends Control

@onready var texture_rect: TextureRect = $TextureRect

func load_card(card):
	var path : String = card.preview_pic_path
	var image_texture :CompressedTexture2D = load(path)
		
	texture_rect.texture = image_texture
