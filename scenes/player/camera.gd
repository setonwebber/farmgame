extends Node3D

@onready var model: Node3D = $"../Model"

@export var mouse_sensitivity: float = 0.003
@export var zoom_increment: float = 0.1

# Camera movement variables
var toggle_mouse: bool
var pitch: float
var yaw: float

func _ready() -> void:
	# Initialising variables on ready
	pitch = rotation.x
	yaw = rotation.y
	toggle_mouse = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	# Mouse pitch and yaw to camera movement
	if event is InputEventMouseMotion and toggle_mouse:
		pitch = clamp(pitch - event.relative.y * mouse_sensitivity, -PI / 2 + 0.01, PI / 2 - 0.01)
		yaw = yaw - event.relative.x * mouse_sensitivity
		rotation = Vector3(pitch, yaw, 0)

func _process(_delta: float) -> void:
	# Mouse input toggle (ESC)
	if Input.is_action_just_pressed("esc"):
		if toggle_mouse:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			toggle_mouse = false
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			toggle_mouse = true
	
	# Mouse scroll wheel to zoom
	if Input.is_action_just_released("mwheel_down"):
		scale = (scale + Vector3.ONE * zoom_increment).clamp(Vector3(0.25, 0.25, 0.25), Vector3(5.0, 5.0, 5.0))
	if Input.is_action_just_released("mwheel_up"):
		scale = (scale - Vector3.ONE * zoom_increment).clamp(Vector3(0.25, 0.25, 0.25), Vector3(5.0, 5.0, 5.0))
		
	# Ties camera to interpolated mesh
	global_position = model.global_position + Vector3(0, 0.5, 0)
