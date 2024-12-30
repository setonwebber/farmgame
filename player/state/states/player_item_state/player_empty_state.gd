class_name PlayerEmptyState extends PlayerItemState

@onready var player: Player = $"../.."

var nearby_items: Array[Item]

## Called by the state machine in _input()
func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine in _process()
func update(_delta: float) -> void:
	pass

## Called by the state machine in _physics_process()
func physics_update(_delta: float) -> void:
	if not nearby_items.is_empty():
		if player.velocity.length() != 0:
			nearby_items.sort_custom(sort_items_ascending)
		if Input.is_action_just_pressed("lmb"):
			print("click")

## Called by the state machine upon entry into the state
func enter() -> void:
	pass

## Called by the state machine upon exiting the current state
func exit() -> void:
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
