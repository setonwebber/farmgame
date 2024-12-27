extends Node

@onready var player = $".."

var nearby_items: Array[Item]
var held_item: Item

func _physics_process(delta: float) -> void:
	if not nearby_items.is_empty() and player.velocity.length() != 0:
		nearby_items.sort_custom(sort_items_ascending)
		print(nearby_items)

func pickup_item() -> void:
	if not held_item:
		pass
	else: # do nothing
		pass

func drop_item() -> void:
	pass

func use_item() -> void:
	pass

func _add_nearby_item(item: Node3D) -> void:
	if item is Item:
		nearby_items.append(item)

func _remove_nearby_item(item: Node3D) -> void:
	if item is Item:
		nearby_items.erase(item)

func sort_items_ascending(item_a: Item, item_b: Item) -> bool:
	var a_dist: float = (item_a.global_position - player.global_position).length()
	var b_dist: float = (item_b.global_position - player.global_position).length()
	if a_dist < b_dist:
		return true
	else:
		return false
