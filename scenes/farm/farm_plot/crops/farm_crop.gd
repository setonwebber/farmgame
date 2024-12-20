extends Resource
class_name FarmCrop

@export var name: String
@export var description: String
@export var crop_models: Array[Mesh]

@export var growth_rate: float
@export var water_usage: float

@export var soil_required: String

@export var crop_yield: int
