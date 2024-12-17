extends Node3D

@onready var physics: CharacterBody3D = $"../Physics"
@onready var camera_pivot: Node3D = $"../../CameraPivot"

var prev_position: Vector3
var prev_rotation_y: float

func _physics_process(_delta: float) -> void:
	# Storing previous state before updating to match physics
	prev_position = global_position
	prev_rotation_y = global_rotation.y

	# Obtain the most recent physics state
	global_position = physics.global_position
	global_rotation.y = physics.global_rotation.y

func _process(_delta: float) -> void:
	var alpha: float = Engine.get_physics_interpolation_fraction()

	# Smoothly interpolate position and rotation
	global_position = lerp(prev_position, physics.global_position, alpha)
	global_rotation.y = lerp_angle(prev_rotation_y, physics.global_rotation.y, alpha)
	
	camera_pivot.global_position = global_position + Vector3(0, 0.5, 0)
