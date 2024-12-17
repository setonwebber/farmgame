extends RichTextLabel

var cropNode: Node
var tileDictionary: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBridge.connect("preview_plot_update", _preview_plot_update)

func _process(delta: float) -> void:
	if Global.BUILDING_MODE:
		visible = true
		if tileDictionary and tileDictionary["tileType"] == "crop":
			cropNode = tileDictionary["placed_building"].get_child(0)
			text = "Crop Name: " + str(cropNode.cropName) + "\n"
			text = text + "Grow Speed: " + str(cropNode.growSpeed) + "\n"
			text = text + "Grow Yield: " + str(cropNode.growYield) + "\n"
			text = text + "Grow Percentage: " + str(cropNode.growPercentage) + "\n"
			text = text + "Crop Tier: " + str(cropNode.cropTier) + "\n"
		else:
			text = " "
	else:
		text = " "
		visible = false

func _preview_plot_update(tile):
	tileDictionary = tile
