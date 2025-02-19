class_name PlayerMovementStateMachine extends Node

# The initial movement state will always be the idle state
@export var state: PlayerMovementState
@onready var player: Player = $".."

func _ready() -> void:
	for state_node: PlayerMovementState in find_children("*", "PlayerMovementState"):
		state_node.player_movement_state_transition.connect(_transition_to_next_state)

	await owner.ready
	state.enter()

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	player.velocity = player.velocity + player.get_gravity() * delta
	state.physics_update(delta)

func _transition_to_next_state(target_state_path: String) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return

	state.exit()
	state = get_node(target_state_path)
	state.enter()
