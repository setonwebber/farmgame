class_name Crate extends Item

@onready var collision_box: CollisionShape3D = $CollisionShape3D
@onready var model: MeshInstance3D = $Model

func pickup(player: Player) -> void:
	player.ItemStateMachine.item = self
	player.ItemStateMachine._transition_to_next_state("CrateState")

func use(player: Player) -> void:
	if player.farm_plot != null:
		var plot_square: PlotSquare = player.farm_plot.get_plot_square(player.global_position)
		if plot_square != null:
			plot_square.harvested()
