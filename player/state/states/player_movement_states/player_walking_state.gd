class_name PlayerWalkingState extends PlayerMovementState

@onready var player: Player = $"../.."
@onready var camera_pivot: Node3D = $"../../CameraPivot"

var rotation_speed: float = PI * 3

## Called by the state machine in _input()
func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine in _process()
func update(_delta: float) -> void:
	pass

## Called by the state machine in _physics_process()
func physics_update(delta: float) -> void:
	var wasd_vector: Vector2 = Input.get_vector("a", "d", "w", "s")
	if wasd_vector == Vector2.ZERO:
		emit_signal("player_movement_state_transition", "IdleState")
	elif Input.is_action_pressed("lshift"):
		emit_signal("player_movement_state_transition", "RunningState")
	else:
		var direction: Vector3 = (camera_pivot.basis * Vector3(wasd_vector.x, 0, wasd_vector.y))
		direction.y = 0
		direction = direction.normalized()
		
		player.velocity.x = direction.x * player.walk_speed
		player.velocity.z = direction.z * player.walk_speed
		player.rotation.y = lerp_angle(player.rotation.y, atan2(direction.x, direction.z), rotation_speed * delta)
	if Input.is_action_just_pressed("space"):
		emit_signal("player_movement_state_transition", "JumpingState")

	player.move_and_slide()

## Called by the state machine upon entry into the state
func enter() -> void:
	pass

## Called by the state machine upon exiting the current state
func exit() -> void:
	pass
