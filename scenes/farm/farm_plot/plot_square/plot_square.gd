extends Node3D
class_name PlotSquare

@onready var ground_mesh: MeshInstance3D = $MeshInstance3D
@onready var crop_mesh: MultiMeshInstance3D = $MeshInstance3D/MultiMeshInstance3D

@export var soil: FarmSoil
@export var crop: FarmCrop

var growth_tick: int
var grown: bool

func planted():
	# needs to be resetted each time a new crop is planted.
	print($".")
	growth_tick = 0
	grown = false
	# init crop variables
	pass

func grow():
	if crop:
		growth_tick = growth_tick + 1
		if growth_tick < crop.stage_times[-1]:
			for x in range(crop.stage_times.size()):
				if growth_tick >= crop.stage_times[x] and growth_tick < crop.stage_times[x + 1]: 
					# var multimesh is just the multimesh property of multimeshinsance3d
					var multimesh = crop_mesh.multimesh
					# change the multimesh to the current stage model (so far they are all set to the same .obj file)
					multimesh.mesh = crop.stage_models[x]
					# trying to change the instance count just as the crop_yield amount for now but probably make this less when we finalize it
					multimesh.instance_count = crop.crop_yield
					# from what ive gathered so far, multimeshes are buggy as shit to work with so good luck
					# im trying to just do these basic things but they just dont work for some reason and theres like a million reasons why
					# so far, the mesh cant be a packedscene, .obj is the only format that supports straight to mesh so thats what i used so far.
					# transfering a packedscene into a mesh is so annoying its not worth it
					# its randomizing them to insane transform values (scale and transform) and i cant really find a way to fix it lmao
					# honestly good luck
					
		else:
			grown = true
			CropGrowth.crops_placed.erase(self)
