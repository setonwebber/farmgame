extends Node3D

# this is a preloaded script that will encompass a bunch of functions that we might wanna use in a lot of different scripts

func load_from_file(dir):
	var json = JSON.new()
	var file = FileAccess.open(dir, FileAccess.READ)
	var content = file.get_as_text()
	json.parse(content)
	return json.data

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
