extends Node3D
class_name PlotSquare

@onready var ground_mesh: MeshInstance3D = $MeshInstance3D

var soil: FarmSoil
var crop: FarmCrop = load("res://scenes/farm/crops/carrot/carrot.tres")

var mesh_instances: Array[MeshInstance3D]
@export var mesh_grid_size: int

var crop_instances: Array[MeshInstance3D]
var crop_instance: MeshInstance3D

var crop_yield: int
var growth_time: int
var stage_times: Array[int]

var growth_tick: int
var grown: bool
var current_stage: int = 0

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

# this will be replaced with planted() when the planting is actually setup
func _ready() -> void:
	# Initialize mesh instances for each farm plot
	for x in range(mesh_grid_size):
		for z in range(mesh_grid_size):
			var mesh_instance = MeshInstance3D.new()
			var initial_stage_scale = randf_range(0.08, 0.14)
			
			# Calculate the position based on the grid
			mesh_instance.position = Vector3(
				(x / float(mesh_grid_size)) - 0.40, 
				0, 
				(z / float(mesh_grid_size)) - 0.40
			)
			
			mesh_instance.mesh = null  # Initially empty
			mesh_instance.visibility_range_end = 15
			mesh_instance.lod_bias = 0.001
			
			mesh_instances.append(mesh_instance)
			add_child(mesh_instance)
	
	growth_tick = 0
	grown = false
	CropGrowth.crops_placed[self] = true
	
	# this will be the planted() func, but since it doesnt work yet ill make it here.
	planted()

func planted():
	# Randomize crop yield and growth time (from a range of cropyield +- 10%), ensuring they don't go below 1
	crop_yield = max(1, rng.randi_range(crop.crop_yield - int(crop.crop_yield * 0.1), crop.crop_yield + int(crop.crop_yield * 0.1)))
	growth_time = max(1, rng.randi_range(crop.growth_time - int(crop.growth_time * 0.1), crop.growth_time + int(crop.growth_time * 0.1)))

	# recalculate stage_times 
	var interval = growth_time / crop.stage_models.size()
	var calculated_stages: Array[int]

	for i in range(crop.stage_models.size()):
		calculated_stages.append(floor(i * interval))
	
	stage_times = calculated_stages

	# print("Crop yield: ", crop_yield, " Crop growth: ", growth_time)

	# Get a shuffled list of unique indices
	var available_indices = Array(range(mesh_grid_size * mesh_grid_size))
	available_indices.shuffle()

	# Place crops randomly in unique spots
	for i in range(min(crop_yield, mesh_grid_size * mesh_grid_size)):
		var crop_instance = mesh_instances[available_indices[i]]
		var crop_instance_scale = randf_range(0.08, 0.14)
		
		crop_instance.transform.basis = Basis(Vector3(0, 1, 0), randf_range(0, TAU))
		crop_instance.mesh = crop.stage_models[0]
		crop_instance.scale = Vector3(crop_instance_scale, crop_instance_scale, crop_instance_scale)
		
		crop_instances.append(crop_instance)
		

func harvested():
	for crop_instance in crop_instances:
		crop_instance.mesh == null
	crop == null
	crop_instances.clear()

func grow():
	if crop:
		growth_tick += 1
		# Check if the crop has reached the growth time
		if growth_tick < growth_time:
			# Determine the current stage based on growth_tick
			for x in range(stage_times.size()):
				if growth_tick == stage_times[x]:
					current_stage = x
					# Update the mesh of each crop instance
					for crop_instance in crop_instances:
						crop_instance.mesh = crop.stage_models[x]
		else:
			# Mark as grown and remove from active crops
			for crop_instance in crop_instances:
				pass
				# need a "grown model" or something.
			grown = true
			CropGrowth.crops_placed.erase(self)
