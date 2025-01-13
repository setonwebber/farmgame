class_name Player extends CharacterBody3D

var farm_plot: FarmPlot = null

var walk_speed: float = 3.0
var running_speed: float = 5.0

@onready var MovementStateMachine: PlayerMovementStateMachine = $MovementStateMachine
@onready var ItemStateMachine: PlayerItemStateMachine = $ItemStateMachine
