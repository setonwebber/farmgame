extends Area3D

# this is the old player detection, slightly better (not using the signal bridge since its kinda unneeded here) but also slightly worse...
# only adding so i can deal with the placing stuff properly but if you replace this with a different system...
# as long as you're doing the functions that are called we all good.

@onready var farm_plot: FarmPlot = $".."
var bodies: Array[Node3D]
var players: Array[Player]


func _process(_delta: float) -> void:
	# if the collision box is colliding with any bodies
	if has_overlapping_bodies():
		bodies = get_overlapping_bodies()
		
		# loop through each body
		for player in bodies:
			# check if player class
			if player is Player:
				# call function in the player 
				player.farming_component.body_entered_plot(farm_plot)
				
				if players.has(player) == false:
					players.append(player)
	
	# check if all the players that were in the plot are still in the plot, if they arent, call body_left_plot function
	for player in players:
		if bodies.has(player) == false:
			player.farming_component.body_left_plot()
			players.clear()
