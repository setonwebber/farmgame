extends Node

@onready var physics_body: CharacterBody3D = $"../Physics/PhysicsBody"
@onready var hotbar: Node = $"../HotBar"

var occupied_plot: FarmPlot
var owned_plot: FarmPlot


func _input(event: InputEvent) -> void:
	if event.is_action_released("crop_place"):
		crop_place()
	elif event.is_action_released("crop_harvest"):
		crop_harvest()

func crop_place():
	if occupied_plot and hotbar.SELECTED_CROP: # and owned_plot == occupied_plot (for when i do ownership)
		print("first_pass")
		print(occupied_plot)
		var plot_square: PlotSquare = occupied_plot.get_plot_square(physics_body.position)
		print(plot_square)
		if plot_square and plot_square.crop == null:
			plot_square.crop == hotbar.SELECTED_CROP
			print(plot_square, hotbar.SELECTED_CROP)

func crop_harvest():
	if occupied_plot: # and owned_plot == occupied_plot (for when i do ownership)
		return

func body_entered_plot(farm_plot: FarmPlot):
	if farm_plot:
		occupied_plot = farm_plot

func body_left_plot():
	occupied_plot = null
