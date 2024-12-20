extends Node3D
class_name FarmPlot

@onready var collision_box: CollisionShape3D = $Area3D/CollisionBox
var plot_square_scene = preload("res://scenes/farm/farm_plot/plot_square/plot_square.tscn")

@export var plot_width: int
@export var plot_height: int

var plot_array: Array[Array]

func _ready() -> void:
	# Creates a new box shape to match the physics bounding box
	var temp_box: BoxShape3D = BoxShape3D.new()
	temp_box.size = Vector3(plot_width + 2, 2, plot_height + 2)
	collision_box.shape = temp_box
	
	# Creates a 2D array of PlotSquare objects, 
	for x in range(plot_width):
		plot_array.append([])
		for z in range(plot_height):
			var plot_square: PlotSquare = plot_square_scene.instantiate()
			plot_square.position = Vector3(0.5 + x - (plot_width / 2), 0, 0.5 + z - (plot_height / 2))
			add_child(plot_square)
			plot_array[x].append(plot_square)
