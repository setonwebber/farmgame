extends Node

# temporarily gonna hard code this to some random  carrot model
var SELECTED_CROP: FarmCrop
var BUIDLING_MODE: bool = true

@export var hotbar_list: Array[FarmCrop]
var hotbar_input_buffer: String

func _input(event: InputEvent):
	if event.is_action_released("hotbar_1"):
		if hotbar_input_buffer != "hotbar_1":
			SELECTED_CROP = hotbar_list[0]
			hotbar_input_buffer = "hotbar_1"
			BUIDLING_MODE = true
		else:
			hotbar_input_buffer = " "
			BUIDLING_MODE = false
	elif event.is_action_released("hotbar_2"):
		if hotbar_input_buffer != "hotbar_2":
			SELECTED_CROP = hotbar_list[1]
			hotbar_input_buffer = "hotbar_2"
			BUIDLING_MODE = true
		else:
			hotbar_input_buffer = " "
			BUIDLING_MODE = false
	elif event.is_action_released("hotbar_3"):
		if hotbar_input_buffer != "hotbar_3":
			SELECTED_CROP = hotbar_list[2]
			hotbar_input_buffer = "hotbar_3"
			BUIDLING_MODE = true
		else:
			hotbar_input_buffer = " "
			BUIDLING_MODE = false
	elif event.is_action_released("hotbar_4"):
		if hotbar_input_buffer != "hotbar_4":
			SELECTED_CROP = hotbar_list[3]
			hotbar_input_buffer = "hotbar_4"
			BUIDLING_MODE = true
		else:
			hotbar_input_buffer = " "
			BUIDLING_MODE = false
	elif event.is_action_released("hotbar_5"):
		if hotbar_input_buffer != "hotbar_5":
			SELECTED_CROP = hotbar_list[4]
			hotbar_input_buffer = "hotbar_5"
			BUIDLING_MODE = true
		else:
			hotbar_input_buffer = " "
			BUIDLING_MODE = false
