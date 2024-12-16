extends Node

var GLOBAL_RESOURCES_PATH = "res://resources/Global/global_resources.tres"

var card_counter := 0


func _ready() -> void:
	load_counter()
	pass
#region SaveLoadRegion

func save_counter(counter):
	print("save counter ",counter)
	var res = GlobalResource.new()
	res.counter = counter
	ResourceSaver.save(res, GLOBAL_RESOURCES_PATH)

func load_counter():
	var res = ResourceLoader.load(GLOBAL_RESOURCES_PATH)
	card_counter = res.counter
	print("load counter ",card_counter)

func create_card(path : String):
	print("принт фаза ",card_counter)
	load_counter()
	var card = CardData.new()
	print("принт фаза после лода ",card_counter)
	card_counter = card_counter + 1
	image_path_to_res(path, card)
	card.id = card_counter
	card.pic_path = "res://resources/pic/" + str(card.id) + ".png"
	card.preview_pic_path = "res://resources/preview/" + str(card.id) + ".png"
	ResourceSaver.save(card, "res://resources/Cards/card"+str(card_counter)+".tres")
	save_counter(card_counter)
	load_counter()
	
func save_card(card,card_id):
	ResourceSaver.save(card, "res://resources/Cards/card"+str(card_id)+".tres")
#endregion

func image_path_to_res(path : String, res : CardData):
	var image = Image.new()
	image.load(path)
	image.save_png("res://resources/pic/"+str(card_counter)+".png")
	image.shrink_x2()
	image.save_png("res://resources/preview/"+str(card_counter)+".png")
	
