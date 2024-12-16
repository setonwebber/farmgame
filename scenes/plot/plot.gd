extends Node3D

# @export var OWNER
@onready var emptyPlot: PackedScene = preload("res://scenes/plot/tiles/empty_plot.tscn")
var emptyPlotBuffer: Node
var PLOTSIZE: int = 16

var plotArray: Array
var plotArrayRow: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in PLOTSIZE:
		plotArrayRow = []
		for z in PLOTSIZE:

			emptyPlotBuffer = emptyPlot.instantiate()
			add_child(emptyPlotBuffer)
			emptyPlotBuffer.position = Vector3(0.5 + x, 0, 0.5 + z)
			var emptyPlotDictionary: Dictionary = {
				"tileType": "empty",
				"isOccupied": false,
				"node": emptyPlotBuffer
			}
			plotArrayRow.append(emptyPlotDictionary)
			
		plotArray.append(plotArrayRow)


func _process(_delta: float) -> void:
	if Input.is_action_just_released("building_place"):
		print(get_tile_from_position(get_cursor_world_position()))

func get_tile_from_position(pos: Vector3):
	
	var plotPosX: int = floor(pos.x - position.x)
	var plotPosZ: int = floor(pos.z - position.z)
	print(floor(plotPosX), floor(plotPosZ))
	
	# if the plotpos x or z is in the range of 0 and plotsize - 1 (31)
	if plotPosX <= PLOTSIZE - 1 and plotPosX >= 0 and plotPosZ <= PLOTSIZE - 1 and plotPosZ >= 0:
		return plotArray[floor(plotPosX)][floor(plotPosZ)]
	
	
func get_cursor_world_position() -> Vector3:
	# stole this from the internet, it just gets the world position of where the cursor is when called.
	const RAY_DISTANCE = 64.0
	
	var camera: Camera3D = get_viewport().get_camera_3d()
	if not is_instance_valid(camera): return Vector3.ZERO
	var mouse_pos = get_viewport().get_mouse_position()
	
	var from: Vector3 = camera.project_ray_origin(mouse_pos)
	var to: Vector3 = from + camera.project_ray_normal(mouse_pos) * RAY_DISTANCE
	
	var ray_params := PhysicsRayQueryParameters3D.create(from, to)
	var ray_result: Dictionary = get_world_3d().direct_space_state.intersect_ray(ray_params)
	var vector_result = ray_result.get("position", to); vector_result.y = 0
	return vector_result # return Vector3.ZERO if needed
