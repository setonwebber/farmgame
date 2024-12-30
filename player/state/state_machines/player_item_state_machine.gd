class_name PlayerItemStateMachine extends Node

# The initial movement state will always be the idle state
@export var state: PlayerItemState

func _ready() -> void:
	for state_node: PlayerItemState in find_children("*", "PlayerItemState"):
		state_node.player_item_state_transition.connect(_transition_to_next_state)

	await owner.ready
	state.enter()

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)
	# print(state)


func _transition_to_next_state(target_state_path: String) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return

	state.exit()
	state = get_node(target_state_path)
	state.enter()
