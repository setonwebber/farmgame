class_name PlayerCropState extends PlayerState

var crop: CropSeed

## Emitted by the state when it wishes to transition to another state
signal player_crop_state_transition(next_state_path: String)

## Called by the state machine in _input()
func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine in _process()
func update(_delta: float) -> void:
	pass

## Called by the state machine in _physics_process()
func physics_update(_delta: float) -> void:
	pass

## Called by the state machine upon entry into the state
func enter() -> void:
	crop == $"..".item
	reparent(self)

## Called by the state machine upon exiting the current state
func exit() -> void:
	crop == null
