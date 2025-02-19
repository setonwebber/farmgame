class_name PlayerFallingState extends PlayerMovementState

@onready var player: Player = $"../.."

## Called by the state machine in _input()
func handle_input(event: InputEvent) -> void:
	pass

## Called by the state machine in _process()
func update(delta: float) -> void:
	pass

## Called by the state machine in _physics_process()
func physics_update(delta: float) -> void:
	if player.is_on_floor():
		var wasd_vector: Vector2 = Input.get_vector("a", "d", "w", "s")
		if wasd_vector == Vector2.ZERO:
			emit_signal("player_movement_state_transition", "IdleState")
		elif Input.is_action_pressed("lshift"):
			emit_signal("player_movement_state_transition", "RunningState")
		else:
			emit_signal("player_movement_state_transition", "WalkingState")
	player.move_and_slide()

## Called by the state machine upon entry into the state
func enter() -> void:
	pass

## Called by the state machine upon exiting the current state
func exit() -> void:
	pass
