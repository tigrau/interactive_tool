extends Control
class_name MarkerScene

signal marker_changed

@onready var texture_button: TextureButton = %TextureButton
@onready var line_edit: LineEdit = %LineEdit
@onready var label: Label = %Label

var mass_flag_grab := false
var flag_grab := false

var mass_edit_flag := false
var edit_flag := false

var picture_path : String

func _ready() -> void:
	set_positions_of_elements()

func set_positions_of_elements():
	texture_button.position = - texture_button.size / 2.

	line_edit.position.x = texture_button.size.x / 2. + 10
	line_edit.position.y = - line_edit.size.y / 2.
	
	label.position.x = texture_button.size.x / 2. + 10
	label.position.y = - label.size.y / 2.

func on_save_game(Array_of_Markers:Array[MarkerData]):
	var my_data = MarkerData.new()
	my_data.position = global_position
	my_data.text = label.text
	my_data.picture_path = picture_path

func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()

func on_load_game(saved_data:MarkerData):
	global_position = saved_data.position
	line_edit.text = saved_data.text
	label.text = saved_data.text
