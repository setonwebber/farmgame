extends RichTextLabel

var crop_node: Node
var tile_dictionary: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBridge.connect("preview_plot_update", _preview_plot_update)

func _process(delta: float) -> void:
	if Global.BUILDING_MODE:
		visible = true
		if tile_dictionary and tile_dictionary["tileType"] == "crop":
			crop_node = tile_dictionary["placed_building"].get_child(0)
			text = "Crop Name: " + str(crop_node.crop_name) + "\n"
			text = text + "Grow Speed: " + str(crop_node.grow_speed) + "\n"
			text = text + "Grow Yield: " + str(crop_node.grow_yield) + "\n"
			text = text + "Grow Percentage: " + str(crop_node.grow_percentage) + "\n"
			text = text + "Crop Tier: " + str(crop_node.crop_tier) + "\n"
			text = text + "Growth Size: " + str(crop_node.growth_size_y) + "\n"
		else:
			text = " "
	else:
		text = " "
		visible = false

func _preview_plot_update(tile):
	tile_dictionary = tile
