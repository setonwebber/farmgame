class_name Item extends RigidBody3D

var id: String

func pickup(_player: Player) -> void:
	_player.ItemStateMachine.item = self
	_player.ItemStateMachine._transition_to_next_state("ItemState")

func drop(_player: Player) -> void:
	_player.ItemStateMachine.item = null
	_player.ItemStateMachine._transition_to_next_state("EmptyState")

func use(_player: Player) -> void:
	pass
