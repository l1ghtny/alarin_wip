extends CharacterBody2D


const speed: float = 20000.0


@onready
var animated_sprite = $AnimatedSprite2D
@onready
var test = $CollisionShape2D

@export var player_max_health := 100
@onready var player_current_health := player_max_health


func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_horizontal := Input.get_axis("move_left", "move_right")
	var direction_vertical := Input.get_axis('move_up', 'move_down')
	if direction_horizontal:
		velocity.x = direction_horizontal * speed * delta
		if velocity.x > 0:
			animated_sprite.flip_h = false
		else:
			animated_sprite.flip_h = true

	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if direction_vertical:
		velocity.y = direction_vertical * speed * delta
	else:
		velocity.y = move_toward(direction_vertical, 0, speed)

	if velocity:
		animated_sprite.play('run')
	else:
		animated_sprite.play("idle")


	move_and_collide(velocity * delta)


# У такого подхода есть проблема: повторная атака не регистрируется, надо что-то с этим делать
func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.visible:
		print('hit')


func _on_hurt_box_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
