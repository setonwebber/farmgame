extends Node

# this will control the building/crop that will be placed when the action is clicked, and what buildings are in the hotbar. the hotbarlist will be changed with the inventory when i get to it
var BUILDING_MODE: bool
var SELECTED_BUILDING: PackedScene

var hotbarList: Array
var hotbarInputBuffer: String

# some dictionaries that will house all the information we'll need for the buildings
var buildingsDictionary: Array = Functions.load_from_file("res://assets/dictionaries/buildings.txt")
var cropsDictionary: Array = Functions.load_from_file("res://assets/dictionaries/crops.txt")

func _ready() -> void:
	hotbarList.append(cropsDictionary[0]["cropScene"])


func _input(event: InputEvent):
	if event.is_action_released("hotbar_1"):
		if hotbarInputBuffer != "hotbar_1":
			SELECTED_BUILDING = load(hotbarList[0])
			hotbarInputBuffer = "hotbar_1"
			BUILDING_MODE = true
		else:
			hotbarInputBuffer = " "
			BUILDING_MODE = false
	elif event.is_action_released("hotbar_2"):
		if hotbarInputBuffer != "hotbar_2":
			SELECTED_BUILDING = load(hotbarList[1])
			hotbarInputBuffer = "hotbar_2"
		else:
			hotbarInputBuffer = " "
			BUILDING_MODE = false
	elif event.is_action_released("hotbar_3"):
		if hotbarInputBuffer != "hotbar_3":
			SELECTED_BUILDING = load(hotbarList[2])
			hotbarInputBuffer = "hotbar_3"
		else:
			hotbarInputBuffer = " "
			BUILDING_MODE = false
	elif event.is_action_released("hotbar_4"):
		if hotbarInputBuffer != "hotbar_4":
			SELECTED_BUILDING = load(hotbarList[3])
			hotbarInputBuffer = "hotbar_4"
		else:
			hotbarInputBuffer = " "
			BUILDING_MODE = false
	elif event.is_action_released("hotbar_5"):
		if hotbarInputBuffer != "hotbar_5":
			SELECTED_BUILDING = load(hotbarList[4])
			hotbarInputBuffer = "hotbar_5"
		else:
			hotbarInputBuffer = " "
			BUILDING_MODE = false
