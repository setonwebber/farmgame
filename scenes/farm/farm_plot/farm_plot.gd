extends Node3D
class_name FarmPlot

@onready var collision_box: CollisionShape3D = $Area3D/CollisionBox
var plot_square_scene = preload("res://scenes/farm/farm_plot/plot_square/plot_square.tscn")

@export var plot_width: int
@export var plot_height: int

var plot_array: Array[Array] = []

func _ready() -> void:
	# Creates a new box shape to match the physics bounding box
	var temp_box: BoxShape3D = BoxShape3D.new()
	temp_box.size = Vector3(plot_width + 2, 2, plot_height + 2)
	collision_box.shape = temp_box
	collision_box.position = Vector3(plot_width / 2, 0, plot_height / 2)
	
	# Creates a 2D array of PlotSquare objects, 
	for x in range(plot_width):
		plot_array.append([])
		for z in range(plot_height):
			var plot_square: PlotSquare = plot_square_scene.instantiate()
			plot_square.position = Vector3(0.5 + x, 0, 0.5 + z)
			plot_array[x].append(plot_square)
			add_child(plot_array[x][z])

func get_plot_square(global_location: Vector3) -> PlotSquare:
	var local_position: Vector3 = to_local(global_location)
	var plot_x: int = floor(local_position.x)
	var plot_z: int = floor(local_position.z)
	if (0 <= plot_x and plot_x < plot_width) and (0 <= plot_z and plot_z < plot_height):
		return plot_array[plot_x][plot_z]
	else:
		return null
