extends Node
class_name CropComponent

# References
@onready var parent_player: CharacterBody3D = $"../Physics/PhysicsBody"
@onready var hotbar_component: Node = $"../HotbarComponent"
@onready var resource_component: Node = $"../ResourceComponent"

# Preview building instance
var preview_building: Node = preload("res://scenes/plot/tiles/preview_tile.tscn").instantiate()

# Plot and tile management
var current_plot: Node
var current_tile: Dictionary
var previous_tile: Dictionary

# Input buffer
var hotbar_input_buffer: String

func _ready() -> void:
	SignalBridge.connect("body_entered_plot", _on_body_entered_plot)
	SignalBridge.connect("body_left_plot", _on_body_left_plot)

func _process(_delta: float) -> void:
	update_preview_building()
	if Input.is_action_pressed("building_place"):
		place_crop()
	elif Input.is_action_just_released("building_remove"):
		harvest_crop()

func update_preview_building():
	if not current_plot or not Global.BUILDING_MODE:
		cleanup_preview()
		return

	# Retrieve tile at the player's position
	var new_tile = current_plot.get_tile_from_position(parent_player.global_transform.origin + parent_player.global_transform.basis.z)

	if new_tile:
		# If the player moved to a new tile
		if new_tile != previous_tile:
			remove_preview_from_tile(previous_tile)
			add_preview_to_tile(new_tile)
			SignalBridge.emit_signal("preview_plot_update", new_tile)
			previous_tile = new_tile
	else:
		cleanup_preview()

func cleanup_preview():
	remove_preview_from_tile(previous_tile)
	previous_tile = {}

func add_preview_to_tile(tile: Dictionary):
	if tile.has("node") and not preview_building.is_inside_tree():
		tile["node"].add_child(preview_building)

func remove_preview_from_tile(tile: Dictionary):
	if tile.has("node") and preview_building.is_inside_tree():
		tile["node"].remove_child(preview_building)

func place_crop():
	if not current_plot or not Global.BUILDING_MODE:
		return
	
	var tile = current_plot.get_tile_from_position(parent_player.global_transform.origin + parent_player.global_transform.basis.z)
	if tile and tile["isOccupied"] == false:
		var crop_instance = hotbar_component.SELECTED_BUILDING.instantiate()
		crop_instance.name = "carrot"

		# Update tile properties
		tile["isOccupied"] = true
		tile["tileType"] = "crop"
		tile["placed_building"] = crop_instance

		# Add crop to the tile node
		tile["node"].add_child(crop_instance)
		SignalBridge.emit_signal("preview_plot_update", tile)

func harvest_crop():
	if not current_plot or not Global.BUILDING_MODE:
		return
	
	var tile = current_plot.get_tile_from_position(parent_player.global_transform.origin + parent_player.global_transform.basis.z)
	if tile and tile["isOccupied"]:
		var crop_instance = tile["placed_building"]
		var cropComponent_instance = crop_instance.get_child(0)
		if cropComponent_instance.grow_percentage == 100:
			# Update tile properties
			tile["isOccupied"] = false
			tile["tileType"] = "Empty"
			tile["placed_building"] = null

			crop_instance.queue_free()
			SignalBridge.emit_signal("preview_plot_update", tile)
			SignalBridge.emit_signal("crop_harvested", cropComponent_instance.crop_ID, cropComponent_instance.grow_yield)

func _on_body_entered_plot(player_node, plot):
	if player_node == parent_player:
		current_plot = plot

func _on_body_left_plot(player_node):
	if player_node == parent_player:
		current_plot = null
