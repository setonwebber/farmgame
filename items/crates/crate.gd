class_name Crate extends Item

@onready var collision_box: CollisionShape3D = $CollisionShape3D
@onready var model: MeshInstance3D = $Model

func pickup(_player: Player) -> void:
	_player.ItemStateMachine.item = self
	_player.ItemStateMachine._transition_to_next_state("CrateState")

func use(_player: Player) -> void:
	pass
