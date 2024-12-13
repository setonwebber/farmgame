extends Node3D

var mouse_sensitivity: float = 0.1
var yaw: float = 0
var pitch: float = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		yaw = yaw - event.relative.x * mouse_sensitivity
		pitch = clamp(pitch - event.relative.y * mouse_sensitivity, -89, 89)
		
		rotation_degrees = Vector3(pitch, yaw, 0)

func _process(delta: float):
	if Input.is_action_just_pressed("ui_cancel"): 
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
