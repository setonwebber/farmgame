extends Node3D
class_name PlotSquare

@onready var ground_mesh: MeshInstance3D = $MeshInstance3D

@export var soil: FarmSoil
@export var crop: FarmCrop

var growth_tick: int
var grown: bool

func planted():
	# init crop variables
	pass

func grow():
	growth_tick = growth_tick + 1
	if growth_tick < crop.stage_times[-1]:
		for x in range(crop.stage_times.size()):
			if growth_tick >= crop.stage_times[x] and growth_tick < crop.stage_times[x + 1]: 
				# change model of crop 
				pass
	else:
		grown = true
		CropGrowth.crops_placed.erase(self)
