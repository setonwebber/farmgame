extends Node

@export var SELECTED_BUILDING: PackedScene
@export var hotbarList: Array

var buildingsDictionary: Array = functions.load_from_file("res://assets/dictionaries/buildings.txt")
var cropsDictionary: Array = functions.load_from_file("res://assets/dictionaries/crops.txt")

func _ready():
	hotbarList.append(cropsDictionary[0]["cropScene"])

#
func _input(event: InputEvent):
	if event.is_action_released("hotbar_1"):
		SELECTED_BUILDING = hotbarList[0]
	buildingsDictionary
