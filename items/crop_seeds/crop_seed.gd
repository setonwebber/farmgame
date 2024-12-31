class_name CropSeed extends Item

func pickup(_player: Player) -> void:
	print(_player.ItemStateMachine)
	
	_player.ItemStateMachine.item = self
	_player.ItemStateMachine._transition_to_next_state("CropState")
