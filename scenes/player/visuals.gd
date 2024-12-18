extends Node

@onready var camera_pivot: Node3D = $CameraPivot
@onready var model: Node3D = $Model
@onready var physics_body: CharacterBody3D = $"../Physics/PhysicsBody"

@export var mouse_sensitivity: float = 0.003
@export var zoom_increment: float = 0.1

# Camera movement variables
var toggle_mouse: bool
var pitch: float
var yaw: float

# Model interpolation variables
var alpha: float
var model_prev_position: Vector3
var model_prev_rotation_y: float

func _ready() -> void:
	# Initialising variables on ready
	pitch = camera_pivot.rotation.x
	yaw = camera_pivot.rotation.y
	toggle_mouse = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	# Mouse pitch and yaw to camera movement
	if event is InputEventMouseMotion and toggle_mouse:
		pitch = clamp(pitch - event.relative.y * mouse_sensitivity, -PI / 2 + 0.01, PI / 2 - 0.01)
		yaw = yaw - event.relative.x * mouse_sensitivity
		camera_pivot.rotation = Vector3(pitch, yaw, 0)

func _physics_process(delta: float) -> void:
	# Storing previous model position and rotation for interpolation
	model_prev_position = model.global_position
	model_prev_rotation_y = model.global_rotation.y
	
	# Obtaining newest physics_body position and rotation for interpolation
	model.global_position = physics_body.global_position
	model.global_rotation.y = physics_body.global_rotation.y

func _process(_delta: float) -> void:
	# Mouse input toggle (ESC)
	if Input.is_action_just_pressed("toggle_mouse"):
		if toggle_mouse:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			toggle_mouse = false
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			toggle_mouse = true
	
	# Mouse scroll wheel to zoom
	if Input.is_action_just_released("zoom_out"):
		camera_pivot.scale = (camera_pivot.scale + Vector3.ONE * zoom_increment).clamp(Vector3(0.25, 0.25, 0.25), Vector3(5.0, 5.0, 5.0))
	if Input.is_action_just_released("zoom_in"):
		camera_pivot.scale = (camera_pivot.scale - Vector3.ONE * zoom_increment).clamp(Vector3(0.25, 0.25, 0.25), Vector3(5.0, 5.0, 5.0))
	
	# Interpolating mesh between physics ticks
	alpha = Engine.get_physics_interpolation_fraction()
	model.global_position = lerp(model_prev_position, physics_body.global_position, alpha)
	model.global_rotation.y = lerp_angle(model_prev_rotation_y, physics_body.global_rotation.y, alpha)
	
	# Ties camera to interpolated mesh
	camera_pivot.global_position = model.global_position + Vector3(0, 0.5, 0)
