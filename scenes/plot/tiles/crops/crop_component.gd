extends Node
class_name crop

#growspeed is growPercentagePerSecond
@export var growSpeed: float
@export var growYield: int
@export var cropName: String

var growPercentage: float
var cropTier: int

var growthSize: float

var grown: bool

@onready var cropModel: Node3D = $"../.."
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var rarity: int

func _ready() -> void:
	rarity = set_crop_tier(rng.randf_range(0, 100))
	growthSize = rng.randf_range(0.1, rarity)
	growSpeed = growSpeed * rng.randf_range(1, rarity)
	growYield = growYield * rng.randf_range(1, rarity)
	cropModel.scale = Vector3.ZERO
	$Timer.start()

func _process(delta: float) -> void:
	if growPercentage >= 100:
		growPercentage = 100
		grown = true
		$Timer.stop()
	else:
		if $Timer.is_stopped():
			$Timer.start()
		grown = false

func _on_timer_timeout():
	if not grown:
		growPercentage = growPercentage + growSpeed
		cropModel.scale = Vector3(
			clamp(growPercentage * growthSize / 100, 0.1, 2), 
			clamp(growPercentage * growthSize / 100, 0.1, 20), 
			clamp(growPercentage * growthSize / 100, 0.1, 2))

func set_crop_tier(rarity):
	if rarity >= 0 and rarity < 50:
		cropTier = 1
	elif rarity >= 50 and rarity < 75:
		cropTier = 2
	elif rarity >= 75 and rarity < 85:
		cropTier = 3
	elif rarity >= 85 and rarity < 93:
		cropTier = 4
	elif rarity >= 93 and rarity < 98:
		cropTier = 5
	elif rarity >= 98 and rarity <= 100:
		cropTier = 6
	else:
		cropTier = 1  # Default case if out of bounds

	return cropTier
