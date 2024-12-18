extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBridge.connect("hotbar_update", _on_hotbar_update)
	
func _on_hotbar_update(SELECTED_BUILDING):
	if SELECTED_BUILDING:
		text = str(SELECTED_BUILDING.instantiate().get_child(0).get_child(0).cropName)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.BUILDING_MODE:
		visible = true
	else: 
		visible = false
