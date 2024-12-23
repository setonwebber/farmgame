extends Node

@onready var physics_body: CharacterBody3D = $PhysicsBody
@onready var camera_pivot: Node3D = $"../Visuals/CameraPivot"

var speed: float = 5.0
var jump_velocity: float = 4.5

var input_dir: Vector2
var direction: Vector3

func _physics_process(delta: float) -> void:
	# Obtains desired movement direction vector, projects it onto the xz plane and then normalises it
	input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	direction = (camera_pivot.basis * Vector3(input_dir.x, 0, input_dir.y))
	direction.y = 0
	direction = direction.normalized()
	
	# Gravity calculations
	if not physics_body.is_on_floor():
		physics_body.velocity = physics_body.velocity + physics_body.get_gravity() * delta

	# Jumping
	if Input.is_action_just_pressed("jump") and physics_body.is_on_floor():
		physics_body.velocity.y = jump_velocity
	
	# Sprinting
	if Input.is_action_just_pressed("sprint"):
		speed = speed * 2
	elif Input.is_action_just_released("sprint"):
		speed = speed / 2

	# Movement
	if direction != Vector3.ZERO:
		physics_body.velocity.x = direction.x * speed
		physics_body.velocity.z = direction.z * speed
		physics_body.rotation.y = atan2(direction.x, direction.z)
	else:
<<<<<<< Updated upstream
		physics_body.velocity.x = move_toward(physics_body.velocity.x, 0, speed)
		physics_body.velocity.z = move_toward(physics_body.velocity.z, 0, speed)
=======
		# Jumping
		if Input.is_action_just_pressed("jump") and physics_body.is_on_floor():
			physics_body.velocity.y = jump_velocity
		
		# Sprinting
		if Input.is_action_just_pressed("sprint"):
			speed = speed * 2
		elif Input.is_action_just_released("sprint"):
			speed = speed / 2

		# Movement
		if direction != Vector3.ZERO:
			physics_body.velocity.x = direction.x * speed
			physics_body.velocity.z = direction.z * speed
			physics_body.rotation.y = lerp_angle(physics_body.rotation.y, atan2(direction.x, direction.z), rotation_speed * delta)
		else:
			physics_body.velocity.x = move_toward(physics_body.velocity.x, 0, speed)
			physics_body.velocity.z = move_toward(physics_body.velocity.z, 0, speed)
>>>>>>> Stashed changes
	
	physics_body.move_and_slide()
