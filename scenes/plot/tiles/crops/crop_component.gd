extends Node

#dictionary containing all crop values
var crops_dictionary: Array = Functions.load_from_file("res://assets/dictionaries/crops.txt")

#grow_speed is grow_percentagePerSecond
@export var crop_ID: int
var grow_speed: float = crops_dictionary[crop_ID]["grow_speed"]
var grow_yield: int = crops_dictionary[crop_ID]["grow_yield"]
var crop_name: String = crops_dictionary[crop_ID]["crop_name"]

var grow_percentage: float
var crop_tier: int

var growth_size_x: float; var growth_size_y: float; var growth_size_z: float

var grown: bool

@onready var crop_model: Node3D = $".."
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var rarity: int

func _ready() -> void:
	rarity = set_crop_tier(rng.randf_range(0, 100))
	growth_size_x = rng.randf_range(0.5, rarity)
	growth_size_y = rng.randf_range(1, rarity)
	growth_size_z = rng.randf_range(0.5, rarity)
	grow_speed = grow_speed * rng.randf_range(1, rarity)
	grow_yield = grow_yield * rng.randf_range(1, rarity)
	crop_model.scale = Vector3.ZERO
	$Timer.start()

func _process(delta: float) -> void:
	if grow_percentage >= 100:
		grow_percentage = 100
		$Timer.stop()
	else:
		if $Timer.is_stopped():
			$Timer.start()

func _on_timer_timeout():
	if not grow_percentage >= 100:
		grow_percentage = grow_percentage + grow_speed
		crop_model.scale = Vector3(
			clamp(grow_percentage * growth_size_x / 100, 0.1, 2), 
			clamp(grow_percentage * growth_size_y / 100, 0.1, 20), 
			clamp(grow_percentage * growth_size_z / 100, 0.1, 2))

func set_crop_tier(rarity):
	if rarity >= 0 and rarity < 50:
		crop_tier = 1
	elif rarity >= 50 and rarity < 75:
		crop_tier = 2
	elif rarity >= 75 and rarity < 85:
		crop_tier = 3
	elif rarity >= 85 and rarity < 93:
		crop_tier = 4
	elif rarity >= 93 and rarity < 98:
		crop_tier = 5
	elif rarity >= 98 and rarity <= 100:
		crop_tier = 6
	else:
		crop_tier = 1  # Default case if out of bounds

	return crop_tier
