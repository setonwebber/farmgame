@tool
extends Resource
class_name FarmSoil

## A unique identifier for the soil.
@export var id_code: String

## The display name of a soil.
@export var name: String
## The display description of a soil.
@export var description: String

## A multiplier for crop yield.
@export var fertility: float:
	set(value):
		fertility = max(0, value)
## The capacity in litres the soil can hold.
@export var water_capacity: float:
	set(value):
		water_capacity = max(0, value)

## Stores a .gltf file that should include only material related data for the plot ground
@export var material_data: PackedScene
