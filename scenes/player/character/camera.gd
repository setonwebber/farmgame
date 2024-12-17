extends Node3D

@onready var character: CharacterBody3D = $"../Character/Physics"
@onready var model: Node3D = $"../Character/Model"

var mouse_sensitivity: float = 0.1
var toggle_mouse: bool = true
var zoom_increment: float = 0.1
var yaw: float = rotation_degrees.y
var pitch: float = rotation_degrees.x

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	# Mouse yaw and pitch to camera movement
	if event is InputEventMouseMotion and toggle_mouse:
		yaw = yaw - event.relative.x * mouse_sensitivity
		pitch = clamp(pitch - event.relative.y * mouse_sensitivity, -89, 89)
		rotation_degrees = Vector3(pitch, yaw, 0)

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
		scale = (scale + Vector3.ONE * zoom_increment).clamp(Vector3(0.25, 0.25, 0.25), Vector3(5.0, 5.0, 5.0))
	if Input.is_action_just_released("zoom_in"):
		scale = (scale - Vector3.ONE * zoom_increment).clamp(Vector3(0.25, 0.25, 0.25), Vector3(5.0, 5.0, 5.0))
