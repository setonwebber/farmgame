class_name CropSeed extends Item

func pickup(_player: Player) -> void:
	_player.ItemStateMachine.item = self
	_player.ItemStateMachine._transition_to_next_state("CropState")
