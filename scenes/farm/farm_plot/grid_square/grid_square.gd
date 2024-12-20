extends Node3D
class_name GridSquare

@export var farm_crop: FarmCrop
@export var farm_soil: FarmSoil

func update_grid_square(_delta: float) -> void:
	if farm_crop:
		# instance a multimeshinstance3d
	else: 
		# delete a multimeshinstance3d
