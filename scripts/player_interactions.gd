class_name PlayerInteractions
extends Node2D

@onready var player: CharacterBody2D = get_parent()


func _ready() -> void:
	player.connect('direction_changed', update_direction)	
	pass 


func update_direction(new_direction):
	match new_direction:
		Vector2.UP:
			rotation_degrees = -90
		Vector2.DOWN:
			rotation_degrees = 90
		Vector2.LEFT:
			rotation_degrees = 180
		Vector2.RIGHT:
			rotation_degrees = 0
		_:
			rotation_degrees = 90
	pass
