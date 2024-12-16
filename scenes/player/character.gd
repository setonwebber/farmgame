extends CharacterBody3D

@export var SPEED: float = 5.0
@export var JUMP_VELOCITY: float = 4.5

func _physics_process(delta: float) -> void:
	var camera_pivot: Node3D = $"../CameraPivot"
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction: Vector3 = (camera_pivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var prev_direction: Vector3
	
	# Gravity calculations
	if not is_on_floor():
		velocity = velocity + get_gravity() * delta

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Sprinting
	if Input.is_action_just_pressed("sprint") and is_on_floor():
		SPEED = SPEED * 2
	elif Input.is_action_just_released("sprint"):
		SPEED = SPEED / 2

	# Movement
	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		rotation.y = atan2(velocity.x, velocity.z)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
