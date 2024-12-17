extends Node
class_name crop

#growspeed is crops per minute
@export var growSpeed: int
@export var growYield: int

var growPerSecond: float
var growPercentage: float
var cropTier: int

var grown: bool

func _ready() -> void:
	growPerSecond = 60 / growSpeed
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
		growPercentage = growPercentage + growPerSecond
