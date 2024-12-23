extends Node

@onready var physics_body: CharacterBody3D = $"../Physics/PhysicsBody"
@onready var hotbar: Node = $"../HotBar"

var farm_plot: FarmPlot = null

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("crop_place"):
		crop_place()

func crop_place():
	if farm_plot and hotbar.SELECTED_CROP:
		var plot_square: PlotSquare = farm_plot.get_plot_square(physics_body.global_position)
		if plot_square and not plot_square.crop:
			plot_square.crop = hotbar.SELECTED_CROP
			print(plot_square.crop)
