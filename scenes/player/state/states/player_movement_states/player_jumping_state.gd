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
		emit_signal("player_movement_state_transition", "IdleState")

## Called by the state machine upon entry into the state
func enter() -> void:
	player.velocity.y = jump_velocity

## Called by the state machine upon exiting the current state
func exit() -> void:
	pass
