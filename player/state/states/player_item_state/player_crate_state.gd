class_name PlayerCrateState extends PlayerItemState

@onready var player: Player = $"../.."
@onready var model: Node3D = $"../../Model"
var crate: Crate

## Called by the state machine in _input()
func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine in _process()
func update(_delta: float) -> void:
	pass

## Called by the state machine in _physics_process()
func physics_update(_delta: float) -> void:
	crate.global_position = player.global_position + player.global_basis.z * 0.4 + Vector3(0, 0.3, 0)
	crate.global_basis = player.global_basis
	if Input.is_action_just_released("lmb"):
		crate.use($"../..")
	elif Input.is_action_just_pressed("rmb"):
		crate.drop($"../..")

## Called by the state machine upon entry into the state
func enter() -> void:
	crate = $"..".item
	crate.reparent(self)
	crate.freeze = true

## Called by the state machine upon exiting the current state
func exit() -> void:
	crate == null
	crate.freeze = false
	
	# Drop the crate in front of the player
	crate.position = $"../../Model".global_position + $"../../Model".global_transform.basis.z * 2 + Vector3(0, 0.3, 0)
