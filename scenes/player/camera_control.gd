extends Node3D

var mouse_sensitivity: float = 0.1
var yaw: float = 0
var pitch: float = 0

@onready var player = $"../CharacterBody3D"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _input(event: InputEvent):
	# if right click is held, the camera move will start.
	if Input.is_action_pressed("freeaim") and event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		yaw = yaw - event.relative.x * mouse_sensitivity
		pitch = clamp(pitch - event.relative.y * mouse_sensitivity, -89, 89)
		
		rotation_degrees = Vector3(pitch, yaw, 0)

func _process(_delta: float):
	position = player.position
	
	if Input.is_action_just_released("freeaim"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
