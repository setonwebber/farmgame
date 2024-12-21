extends Area3D

func _on_body_entered(body):
	if body is PlayerPhysicsBody:
		body.get_parent().get_parent().farming.farm_plot = $".."
		print("a body entered the plot area")

func _on_body_exited(body):
	if body is PlayerPhysicsBody:
		body.get_parent().get_parent().farming.farm_plot = null
		print("a body exited the plot area")
