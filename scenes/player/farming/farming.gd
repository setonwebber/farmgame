extends Node

@onready var physics_body: CharacterBody3D = $"../Physics/PhysicsBody"
@onready var hotbar: Node = $"../HotBar"

var farm_plot: FarmPlot = null

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("crop_place"):
		crop_place()

func crop_place():
	# if player standing on a farmplot and has a crop selected.
	if farm_plot and hotbar.SELECTED_CROP:
		var plot_square: PlotSquare = farm_plot.get_plot_square(physics_body.global_position)
		
		# if there is a plot_square where the player is facing and the plot_square doesnt have a crop planted
		if plot_square and not plot_square.crop:
			plot_square.crop = hotbar.SELECTED_CROP
			plot_square.planted()
			
			CropGrowth.crops_placed[plot_square] = true
