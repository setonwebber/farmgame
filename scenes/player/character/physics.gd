extends CharacterBody3D 
class_name player

@onready var camera_pivot: Node3D = $"../../CameraPivot"

var speed: float = 5.0
var jump_velocity: float = 4.5
var input_dir: Vector2
var direction: Vector3
var rotation_speed: float = 15

func _physics_process(delta: float) -> void:
	input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	direction = (camera_pivot.basis * Vector3(input_dir.x, 0, input_dir.y))
	direction.y = 0
	direction = direction.normalized()
	
	# Gravity calculations
	if not is_on_floor():
		velocity = velocity + get_gravity() * delta

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	# Sprinting
	if Input.is_action_just_pressed("sprint"):
		speed = speed * 2
	elif Input.is_action_just_released("sprint"):
		speed = speed / 2

	# Movement
	if direction != Vector3.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		rotation.y = atan2(direction.x, direction.z)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
