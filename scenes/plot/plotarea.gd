extends Area3D

@onready var plot: Node = $".."
var players: Array[Node3D]
var playersBuffer: Array[player]

func _process(delta: float) -> void:
	if has_overlapping_bodies():
		players = get_overlapping_bodies()
		for playerNode in players:
			if playerNode is player:
				SignalBridge.emit_signal("body_entered_plot", playerNode, plot)
				if playersBuffer.has(playerNode) == false:
					playersBuffer.append(playerNode)
	
	for playerNode in playersBuffer:
		if players.has(playerNode) == false:
			SignalBridge.emit_signal("body_left_plot", playerNode)
			playersBuffer.clear()
