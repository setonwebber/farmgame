extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBridge.connect("resource_update", _on_resource_update)
	
func _on_resource_update(resource_dictionary, money):
	text = str(resource_dictionary)
