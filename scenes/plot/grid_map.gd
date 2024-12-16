extends GridMap

var plotDictionary: Dictionary

@export var PLOTSIZE: int = 32

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear()
	for x in PLOTSIZE * 2:
		if x > PLOTSIZE:
			x = (x * -1) % PLOTSIZE
		for z in PLOTSIZE * 2:
			if z > PLOTSIZE:
				z = (z * -1) % PLOTSIZE
			set_cell_item(Vector3(x, 0, z), 0)
			plotDictionary
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_released("building_place"):
		print(get_cursor_world_position().x)
		print(get_cursor_world_position().y)
		print(get_cursor_world_position().z)
		print(local_to_map(get_cursor_world_position()))
		set_cell_item(local_to_map(get_cursor_world_position()), 0) 


func get_cursor_world_position() -> Vector3:
	# stole this from the internet, it just gets the world position of where the cursor is when called.
	const RAY_DISTANCE = 64.0
	
	var camera: Camera3D = get_viewport().get_camera_3d()
	if not is_instance_valid(camera): return Vector3.ZERO
	var mouse_pos = get_viewport().get_mouse_position()
	
	var from: Vector3 = camera.project_ray_origin(mouse_pos)
	var to: Vector3 = from + camera.project_ray_normal(mouse_pos) * RAY_DISTANCE
	
	var ray_params := PhysicsRayQueryParameters3D.create(from, to)
	var ray_result: Dictionary = get_world_3d().direct_space_state.intersect_ray(ray_params)
	var vector_result = ray_result.get("position", to); vector_result.y = 0
	return vector_result # return Vector3.ZERO if needed
