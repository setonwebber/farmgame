extends Node

@onready var physics_body: CharacterBody3D = $"../Physics/PhysicsBody"

var farm_plot: FarmPlot = null

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("crop_place"):
		crop_place()

func crop_place():
	if farm_plot:
		var plot_square: PlotSquare = farm_plot.get_plot_square(physics_body.global_position)
		print(plot_square)
