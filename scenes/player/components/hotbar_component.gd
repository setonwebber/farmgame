extends Node

# some dictionaries that will house all the information we'll need for the buildings
var buildings_dictionary: Array = Functions.load_from_file("res://assets/dictionaries/buildings.txt")
var crops_dictionary: Array = Functions.load_from_file("res://assets/dictionaries/crops.txt")

# this will control the building/crop that will be placed when the action is clicked, and what buildings are in the hotbar. the hotbar_list will be changed with the inventory when i get to it
var SELECTED_BUILDING: PackedScene = null

var hotbar_list: Array[String]
var hotbar_input_buffer: String

func _ready() -> void:
	hotbar_list.append(crops_dictionary[0]["crop_scene"])

func _input(event: InputEvent):
	SignalBridge.emit_signal("hotbar_update", SELECTED_BUILDING)
	if event.is_action_released("hotbar_1"):
		if hotbar_input_buffer != "hotbar_1":
			SELECTED_BUILDING = load(hotbar_list[0])
			hotbar_input_buffer = "hotbar_1"
			Global.BUILDING_MODE = true
		else:
			hotbar_input_buffer = " "
			Global.BUILDING_MODE = false
	elif event.is_action_released("hotbar_2"):
		if hotbar_input_buffer != "hotbar_2":
			SELECTED_BUILDING = load(hotbar_list[1])
			hotbar_input_buffer = "hotbar_2"
			Global.BUILDING_MODE = true
		else:
			hotbar_input_buffer = " "
			Global.BUILDING_MODE = false
	elif event.is_action_released("hotbar_3"):
		if hotbar_input_buffer != "hotbar_3":
			SELECTED_BUILDING = load(hotbar_list[2])
			hotbar_input_buffer = "hotbar_3"
			Global.BUILDING_MODE = true
		else:
			hotbar_input_buffer = " "
			Global.BUILDING_MODE = false
	elif event.is_action_released("hotbar_4"):
		if hotbar_input_buffer != "hotbar_4":
			SELECTED_BUILDING = load(hotbar_list[3])
			hotbar_input_buffer = "hotbar_4"
			Global.BUILDING_MODE = true
		else:
			hotbar_input_buffer = " "
			Global.BUILDING_MODE = false
	elif event.is_action_released("hotbar_5"):
		if hotbar_input_buffer != "hotbar_5":
			SELECTED_BUILDING = load(hotbar_list[4])
			hotbar_input_buffer = "hotbar_5"
			Global.BUILDING_MODE = true
		else:
			hotbar_input_buffer = " "
			Global.BUILDING_MODE = false
