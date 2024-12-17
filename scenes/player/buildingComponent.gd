extends Node

# this will control the building/crop that will be placed when the action is clicked, and what buildings are in the hotbar. the hotbarlist will be changed with the inventory when i get to it
var SELECTED_BUILDING: String
var PLOT_OCCUPIED: Node
var PLOT_AT_PLAYER: Node
var hotbarList: Array

# some dictionaries that will house all the information we'll need for the buildings
var buildingsDictionary: Array = Functions.load_from_file("res://assets/dictionaries/buildings.txt")
var cropsDictionary: Array = Functions.load_from_file("res://assets/dictionaries/crops.txt")

func _ready():
	SignalBridge.connect("body_entered_plot", _on_body_entered_plot)
	SignalBridge.connect("body_left_plot", _on_body_left_plot)
	hotbarList.append(cropsDictionary[0]["cropScene"])

func _on_body_entered_plot(playerNode, plot):
	if playerNode == $"../CharacterBody3D":
		PLOT_AT_PLAYER = plot
	else: 
		PLOT_AT_PLAYER = null

func _on_body_left_plot(playerNode):
	if playerNode == $"../CharacterBody3D":
		PLOT_AT_PLAYER = null

func _input(event: InputEvent):
	if event.is_action_pressed("building_place"):
		pass
	
	if event.is_action_released("hotbar_1"):
		SELECTED_BUILDING = hotbarList[0]
	elif event.is_action_released("hotbar_2"):
		SELECTED_BUILDING = hotbarList[1]
	elif event.is_action_released("hotbar_3"):
		SELECTED_BUILDING = hotbarList[2]
	elif event.is_action_released("hotbar_4"):
		SELECTED_BUILDING = hotbarList[3]
	elif event.is_action_released("hotbar_5"):
		SELECTED_BUILDING = hotbarList[4]
	elif event.is_action_released("hotbar_6"):
		SELECTED_BUILDING = hotbarList[5]
	elif event.is_action_released("hotbar_7"):
		SELECTED_BUILDING = hotbarList[6]
	elif event.is_action_released("hotbar_8"):
		SELECTED_BUILDING = hotbarList[7]
	elif event.is_action_released("hotbar_9"):
		SELECTED_BUILDING = hotbarList[8]
	buildingsDictionary
