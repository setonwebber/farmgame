extends Node

#dictionary containing all crop values
var cropsDictionary: Array = Functions.load_from_file("res://assets/dictionaries/crops.txt")

var money: int
var resource_dictionary: Array[Dictionary]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBridge.connect("crop_harvested", _on_crop_harvested)
	
	# init resource_dictionary
	for crop in cropsDictionary:
		resource_dictionary.append({
			"cropName": crop["cropName"],
			"count": 0
		})
	
func _on_crop_harvested(cropID, cropYield):
	resource_dictionary[cropID]["count"] = resource_dictionary[cropID]["count"] + cropYield
	SignalBridge.emit_signal("resource_update", resource_dictionary, money)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
