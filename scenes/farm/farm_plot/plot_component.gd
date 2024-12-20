extends Node3D
class_name FarmPlot

@onready var ground_mesh: MeshInstance3D = $"../GroundMesh"

var grid_square

@export var plot_width: int = 4
@export var plot_height: int = 6

var plot_array: Array[Array]

func _ready() -> void:
	print(ground_mesh)
	ground_mesh.scale = Vector3(plot_width, 1, plot_height)
	
	var count: int = 0
	for x in plot_width:
		var plot_array_row = []
		for z in plot_height:

			empty_plot_buffer = empty_plot.instantiate()
			add_child(empty_plot_buffer)
			
			empty_plot_buffer.name = "empty_plot" + str(count)
			empty_plot_buffer.position = Vector3(0.5 + x, 0, 0.5 + z)
			
			var empty_plot_dictionary: Dictionary = {
				"tileType": "empty",
				"isOccupied": false,
				"node": empty_plot_buffer,
				"placed_building": null
			}
			
			plot_array_row.append(empty_plot_dictionary)
			
			count = count + 1
			
		plot_array.append(plot_array_row)
	
	empty_plot_buffer = null
