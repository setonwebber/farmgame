class_name Crate extends Item

func pickup(_player: Player) -> void:
	_player.ItemStateMachine.item = self
	_player.ItemStateMachine._transition_to_next_state("CrateState")

func use(_player: Player) -> void:
	pass
