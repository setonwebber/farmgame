extends Node3D
class_name PlotSquare

@onready var ground_mesh: MeshInstance3D = $MeshInstance3D

var soil: FarmSoil
var crop: FarmCrop = load("res://scenes/farm/crops/carrot/carrot.tres")

var growth_tick: int
var grown: bool
var crop_instances: Array[MeshInstance3D] = []
var current_stage: int = 0

# this will be replaced with planted() when the planting is actually setup
func _ready() -> void:
	# Create crop instances
	for i in range(20):
		var crop_mesh_instance = MeshInstance3D.new()
		var initial_stage_scale = randf_range(0.08, 0.14)
		crop_mesh_instance.position = Vector3(randf_range(-0.45, 0.45), 0, randf_range(-0.45, 0.45))
		crop_mesh_instance.scale = Vector3(initial_stage_scale, initial_stage_scale, initial_stage_scale) # temporary
		crop_mesh_instance.mesh = crop.stage_models[0]
		add_child(crop_mesh_instance)
		crop_instances.append(crop_mesh_instance)
	
	growth_tick = 0
	grown = false
	CropGrowth.crops_placed[self] = true

func harvested():
	for crop_instance in crop_instances:
		crop_instance.queue_free()
	crop_instances.clear()

func grow():
	if crop:
		growth_tick += 1
		# Check if the crop has reached the growth time
		if growth_tick < crop.growth_time:
			# Determine the current stage based on growth_tick
			for x in range(crop.stage_times.size()):
				if growth_tick == crop.stage_times[x]:
					current_stage = x
					# Update the mesh of each crop instance
					for crop_instance in crop_instances:
						crop_instance.mesh = crop.stage_models[x]
		else:
			# Mark as grown and remove from active crops
			grown = true
			CropGrowth.crops_placed.erase(self)
