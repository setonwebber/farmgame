extends CharacterBody3D
class_name Player

# this is here so the player_detection script can call the functions in the farming component
@onready var farming_component: Node = $"../../Farming"
