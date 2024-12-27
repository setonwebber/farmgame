extends Node3D
class_name PlotSquare

@onready var ground_mesh: MeshInstance3D = $MeshInstance3D

var soil: FarmSoil
var crop: FarmCrop
