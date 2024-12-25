@tool
extends Resource
class_name FarmCrop

## A unique identifier for the crop.
@export var id_code: String

## The display name of a crop.
@export var name: String
## The display description of a crop.
@export var description: String

## The number of growth ticks required to fully grow the crop.
@export var growth_time: int:
	set(value):
		growth_time = max(0, value)

## The amount of water in litres the crop consumes per growth tick.
@export var water_usage: float:
	set(value):
		water_usage = max(0, value)
## An array of FarmSoil resource instances the crop can grow in.
@export var soil_required: Array[FarmSoil]
## The number of crop "items" that the crop will produce upon completion.
@export var crop_yield: int:
	set(value):
		crop_yield = max(1, value)

## An array of .gltf files for the visual data related to each stage of crop growth.
## The size of the Array represents the number of stages.
@export var stage_models: Array[Mesh]:
	set(value):
		stage_models = value
		stage_times.resize(stage_models.size())
		notify_property_list_changed()
## An array that stores the number of growth ticks until each stage in sequential order.
@export var stage_times: Array[int]:
	set(value):
		stage_times = value
		if(stage_times.size() != stage_models.size()):
			stage_times.resize(stage_models.size())
