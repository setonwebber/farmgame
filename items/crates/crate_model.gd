extends MeshInstance3D

@onready var crate: Crate = $".."

var alpha: float
var prev_position: Vector3
var prev_rotation: Vector3

func _physics_process(_delta: float) -> void:
	# Storing previous model position and rotation for interpolation
	prev_position = global_position
	prev_rotation = global_rotation
	
	# Obtaining newest physics_body position and rotation for interpolation
	global_position = crate.global_position
	global_rotation = crate.global_rotation

func _process(_delta: float) -> void:
	# Interpolating mesh between physics ticks
	alpha = Engine.get_physics_interpolation_fraction()
	global_position = lerp(prev_position, crate.global_position, alpha)
	global_rotation = lerp(prev_rotation, crate.global_rotation, alpha)
