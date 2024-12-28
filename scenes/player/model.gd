extends Node3D

@onready var player: Player = $".."

var alpha: float
var prev_position: Vector3
var prev_rotation_y: float

func _physics_process(_delta: float) -> void:
	# Storing previous model position and rotation for interpolation
	prev_position = global_position
	prev_rotation_y = global_rotation.y
	
	# Obtaining newest physics_body position and rotation for interpolation
	global_position = player.global_position
	global_rotation.y = player.global_rotation.y

func _process(_delta: float) -> void:
	# Interpolating mesh between physics ticks
	alpha = Engine.get_physics_interpolation_fraction()
	global_position = lerp(prev_position, player.global_position, alpha)
	global_rotation.y = lerp_angle(prev_rotation_y, player.global_rotation.y, alpha)
