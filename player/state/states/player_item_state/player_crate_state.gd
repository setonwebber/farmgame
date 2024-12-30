class_name PlayerCrateState extends PlayerItemState

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
	pass

## Called by the state machine upon exiting the current state
func exit() -> void:
	pass
