extends CharacterBody2D

@export var speed := 15000.0


@onready var animated_sprite := $AnimatedSprite2D
@onready var attack_area := $HitBox


var player = null
var start_position :Vector2
var end_positionn :Vector2
var last_direction :bool
var last_direction_attack := false
@export var attacking :bool


func animate():
	if attacking:
		pass
	else:
		if velocity:
			animated_sprite.play("run")
		else: 
			animated_sprite.play("idle")
			
		if velocity.x > 0:
			animated_sprite.flip_h = false
			last_direction = animated_sprite.flip_h
		elif velocity.x == 0:
			animated_sprite.flip_h = last_direction
		else:
			animated_sprite.flip_h = true
			last_direction = animated_sprite.flip_h
		
func move_to_player(delta: float):
	
	if player:
		if attacking == true:
			velocity = Vector2.ZERO
		else:
			velocity = position.direction_to(player.position) * speed * delta

	else:
		velocity = Vector2.ZERO
		
		
func attack_check():
	if player != null:
		if position.distance_to(player.position) < 60 and attacking == false:
			attack()
			
	


func attack():
	print('starting attack')
	attacking = true
	if last_direction == last_direction_attack:
		pass
	else:
		last_direction_attack = not last_direction_attack
		attack_area.position.x = -attack_area.position.x
	attack_area.visible = true
	animated_sprite.play("attack")



func _physics_process(delta: float) -> void:
	animate()
	move_to_player(delta)
	move_and_collide(velocity * delta)
	if not attacking:
		attack_check()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.is_in_group("player"):
		player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == 'attack':
		attack_area.visible = false
		attacking = false
