extends Node3D
class_name PlotSquare

@onready var ground_mesh: MeshInstance3D = $MeshInstance3D

@export var soil: FarmSoil
@export var crop: FarmCrop
