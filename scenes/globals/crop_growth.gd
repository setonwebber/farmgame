extends Node

var crops_placed: Dictionary
var timer: Timer = Timer.new()

func _ready() -> void:
	# Add the timer to the scene tree so it can function properly
	add_child(timer)
	
	# Configure the timer properties
	timer.wait_time = 0.1
	timer.autostart = true
	
	# Connect the timer's timeout signal to the function
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout() -> void:
	# Function to execute on every timer tick
	for crop in crops_placed:
		crop.grow()
