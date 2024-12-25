extends Node3D
class_name PlotSquare

@onready var ground_mesh: MeshInstance3D = $MeshInstance3D

var soil: FarmSoil
var crop: FarmCrop

var growth_tick: int
var grown: bool
var crop_instances: Array[Node]

func planted():
	for i: int in crop.crop_yield:
		crop_instances.append(crop.stage_models[0].instantiate())
		crop_instances[i].position = Vector3(randf_range(-0.45, 0.45), 0, randf_range(-0.45, 0.45))
		crop_instances[i].scale = Vector3(0.1, 0.1, 0.1) # temporary
		add_child(crop_instances[i])
	
	growth_tick = 0
	grown = false
	CropGrowth.crops_placed[self] = true

func harvested():
	for i: int in range(crop_instances.size()):
		crop_instances[i].queue_free()
	crop_instances.clear()
	
func grow():
	if crop:
		growth_tick = growth_tick + 1
		if growth_tick < crop.growth_time:
			for x: int in range(crop.stage_times.size()):
				if growth_tick == crop.stage_times[x]: 
					pass
					# same problem as above, how the fuck??
		else:
			grown = true
			CropGrowth.crops_placed.erase(self)
