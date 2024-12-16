extends Control

@onready var h_box_container: HBoxContainer = $CurrentView/ScrollContainer/VBoxContainer/HBoxContainer
@export var card_scene : PackedScene
 
func _ready() -> void:
	fill_gallery()
	get_tree().get_root().files_dropped.connect(_on_file_drops)

func _on_file_drops(files):
	for file in files:
		print("next file")
		create_card(file)

func create_card(file):
	GlobalScript.create_card(file)
	fill_gallery()

func fill_gallery():
	var dir = DirAccess.open("res://resources/Cards/")
	var counter := -1
	for item in dir.get_files():
		counter += 1
		print(item)
		var item_load = ResourceLoader.load("res://resources/Cards/"+item)
		var gallery_item = TextureButton.new()
		gallery_item.pressed.connect(change_scene_go_to_card_scene.bind(item_load))
		
		gallery_item.set_custom_minimum_size(Vector2(260,255))
		#gallery_item.set_h_size_flags(3)
		gallery_item.set_stretch_mode(3)
		gallery_item.ignore_texture_size = true
		gallery_item.clip_contents = true

		var path : String = item_load.preview_pic_path
		var image_texture :CompressedTexture2D = load(path)
		var image_size = image_texture.get_size()
		
		gallery_item.texture_normal = image_texture
		
		if counter % 7 == 0:
			var new_h_box_container = HBoxContainer.new()
			new_h_box_container.add_child(gallery_item)
			$CurrentView/ScrollContainer/VBoxContainer.add_child(new_h_box_container)
			h_box_container = new_h_box_container
		else:
			h_box_container.add_child(gallery_item)

func change_scene_go_to_card_scene(card):
	$CurrentView.remove_child($CurrentView.get_child(0))
	var instance = card_scene.instantiate()
	$CurrentView.add_child(instance)
	
	instance.load_card(card)


func _on_home_btn_pressed() -> void:
	get_tree().reload_current_scene()
