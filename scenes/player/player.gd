class_name Player extends CharacterBody3D

@onready var camera_pivot: Node3D = $CameraPivot

var speed: float = 3.0
var rotation_speed: float = PI * 3
var jump_velocity: float = 2.5

var input_dir: Vector2
var direction: Vector3

func _physics_process(delta: float) -> void:
	# Obtains desired movement direction vector, projects it onto the xz plane and then normalises it
	input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	direction = (camera_pivot.basis * Vector3(input_dir.x, 0, input_dir.y))
	direction.y = 0
	direction = direction.normalized()
	
	# Gravity calculations
	if not is_on_floor():
		velocity = velocity + get_gravity() * delta
	else:
		# Movement
		if direction != Vector3.ZERO:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
			rotation.y = lerp_angle(rotation.y, atan2(direction.x, direction.z), rotation_speed * delta)
			
			# Sprinting
			if Input.is_action_pressed("sprint"):
				velocity = velocity * 2
				
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
		
		# Jumping
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
			rotation.y = atan2(direction.x, direction.z)
	
	move_and_slide()
