extends Node3D

@onready var crop_component = get_parent()

var growth_size_xz: float; var growth_size_y: float 
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	crop_component.grow_updated.connect(_on_crop_component_grow_updated)
	scale = Vector3.ZERO
	
	position = Vector3(
		rng.randf_range(-0.45, 0.45), 
		0, 
		rng.randf_range(-0.45, 0.45)
	)
	
	growth_size_xz = rng.randf_range(0.5, crop_component.rarity)
	growth_size_y = rng.randf_range(1, crop_component.rarity)
	
func _on_crop_component_grow_updated(grow_percentage) -> void:
	scale = Vector3(
			clamp(grow_percentage * growth_size_xz / 100, 0.3, 2), 
			clamp(grow_percentage * growth_size_y / 100, 0.3, 50), 
			clamp(grow_percentage * growth_size_xz / 100, 0.3, 2))
