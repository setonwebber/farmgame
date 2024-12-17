extends Node

@onready var PARENTPLAYERNODE: CharacterBody3D = $"../CharacterBody3D"

# this will control the building/crop that will be placed when the action is clicked, and what buildings are in the hotbar. the hotbarlist will be changed with the inventory when i get to it
var SELECTED_BUILDING: PackedScene
var PLOT_OCCUPIED: Node
var PLOT_AT_PLAYER: Node

var hotbarList: Array
var plot: Node3D

var tile: Dictionary
var tileNode: Node3D

var crop: Node3D
# some dictionaries that will house all the information we'll need for the buildings
var buildingsDictionary: Array = Functions.load_from_file("res://assets/dictionaries/buildings.txt")
var cropsDictionary: Array = Functions.load_from_file("res://assets/dictionaries/crops.txt")

func _ready():
	SignalBridge.connect("body_entered_plot", _on_body_entered_plot)
	SignalBridge.connect("body_left_plot", _on_body_left_plot)
	hotbarList.append(cropsDictionary[0]["cropScene"])

func place_crop():
	if PLOT_AT_PLAYER and SELECTED_BUILDING:
		if PLOT_AT_PLAYER.get_tile_from_position(PARENTPLAYERNODE.position) and !PLOT_AT_PLAYER.get_tile_from_position(PARENTPLAYERNODE.position)["isOccupied"]:
			crop = SELECTED_BUILDING.instantiate()
			crop.name = "carrot"
			
			tile = PLOT_AT_PLAYER.get_tile_from_position(PARENTPLAYERNODE.position)
			tileNode = tile["node"]
			tile["isOccupied"] = true
			tile["tileType"] = "Carrot"
			
			tileNode.add_child(crop)
	else:
		print("not at plot")

func _on_body_entered_plot(playerNode, plot):
	if playerNode == PARENTPLAYERNODE:
		PLOT_AT_PLAYER = plot
	else: 
		PLOT_AT_PLAYER = null

func _on_body_left_plot(playerNode):
	if playerNode == PARENTPLAYERNODE:
		PLOT_AT_PLAYER = null

func _input(event: InputEvent):
	if event.is_action_pressed("building_place"):
		place_crop()
	
	if event.is_action_released("hotbar_1"):
		SELECTED_BUILDING = load(hotbarList[0])
	elif event.is_action_released("hotbar_2"):
		SELECTED_BUILDING = load(hotbarList[1])
	elif event.is_action_released("hotbar_3"):
		SELECTED_BUILDING = load(hotbarList[2])
	elif event.is_action_released("hotbar_4"):
		SELECTED_BUILDING = load(hotbarList[3])
	elif event.is_action_released("hotbar_5"):
		SELECTED_BUILDING = load(hotbarList[4])
	elif event.is_action_released("hotbar_6"):
		SELECTED_BUILDING = load(hotbarList[5])
	elif event.is_action_released("hotbar_7"):
		SELECTED_BUILDING = load(hotbarList[6])
	elif event.is_action_released("hotbar_8"):
		SELECTED_BUILDING = load(hotbarList[7])
	elif event.is_action_released("hotbar_9"):
		SELECTED_BUILDING = load(hotbarList[8])
	buildingsDictionary
