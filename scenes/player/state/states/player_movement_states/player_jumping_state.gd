class_name PlayerJumpingState extends PlayerMovementState

@onready var player: Player = $"../.."

var jump_velocity: float = 3.0

## Called by the state machine in _input()
func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine in _process()
func update(_delta: float) -> void:
	pass

## Called by the state machine in _physics_process()
func physics_update(delta: float) -> void:
	player.velocity = player.velocity + player.get_gravity() * delta
	player.move_and_slide()
	if player.is_on_floor():
		var wasd_vector: Vector2 = Input.get_vector("a", "d", "w", "s")
		if wasd_vector == Vector2.ZERO:
			emit_signal("player_movement_state_transition", "IdleState")
		elif Input.is_action_pressed("lshift"):
			emit_signal("player_movement_state_transition", "RunningState")
		else:
			emit_signal("player_movement_state_transition", "WalkingState")

## Called by the state machine upon entry into the state
func enter() -> void:
	player.velocity.y = jump_velocity

## Called by the state machine upon exiting the current state
func exit() -> void:
	pass
