extends Node3D

# @export var OWNER
@onready var emptyPlot: PackedScene = preload("res://scenes/plot/tiles/empty_plot.tscn")
var emptyPlotBuffer: Node
var PLOTSIZE: int = 16

var plotArray: Array
var plotArrayRow: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var count: int = 0
	for x in PLOTSIZE:
		plotArrayRow = []
		for z in PLOTSIZE:

			emptyPlotBuffer = emptyPlot.instantiate()
			add_child(emptyPlotBuffer)
			
			emptyPlotBuffer.name = "emptyPlot" + str(count)
			emptyPlotBuffer.position = Vector3(0.5 + x, 0, 0.5 + z)
			
			var emptyPlotDictionary: Dictionary = {
				"tileType": "empty",
				"isOccupied": false,
				"node": emptyPlotBuffer
			}
			
			plotArrayRow.append(emptyPlotDictionary)
			
			count = count + 1
			
		plotArray.append(plotArrayRow)


func _process(_delta: float) -> void:
	if Input.is_action_just_released("building_place"):
		print(get_tile_from_position(functions.get_cursor_world_position()))

func get_tile_from_position(pos: Vector3):
	# take the origin point of the plot by the position clicked, this gives us the relative position of the click towards this chunk
	var plotPosX: int = floor(pos.x - position.x)
	var plotPosZ: int = floor(pos.z - position.z)
	
	# if the plotpos x or z is in the range of 0 and plotsize - 1 (31)
	if plotPosX <= PLOTSIZE - 1 and plotPosX >= 0 and plotPosZ <= PLOTSIZE - 1 and plotPosZ >= 0:
		return plotArray[floor(plotPosX)][floor(plotPosZ)]
