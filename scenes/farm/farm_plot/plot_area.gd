extends Area3D

func _on_body_entered(body):
	if body is PlayerPhysicsBody:
		body.get_node("../../Farming").farm_plot = $".."

func _on_body_exited(body):
	if body is PlayerPhysicsBody:
		body.get_node("../../Farming").farm_plot = null
