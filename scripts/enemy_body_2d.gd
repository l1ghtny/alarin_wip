extends CharacterBody2D

@export var speed := 15000.0

@onready var animated_sprite := $AnimatedSprite2D


var player = null
var start_position :Vector2
var end_positionn :Vector2

func animate():
	if velocity:
		animated_sprite.animation = 'run'
	else: 
		animated_sprite.animation = 'idle'
		
		
func move_to_player(delta: float):
	if player:
		velocity = position.direction_to(player.position) * speed * delta

		if (player.position.x - position.x) > 0:
			animated_sprite.flip_h = false
		else:
			animated_sprite.flip_h = true

	else:
		velocity = Vector2.ZERO


func _physics_process(delta: float) -> void:
	animate()
	move_to_player(delta)
	move_and_collide(velocity * delta)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null
