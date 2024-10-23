extends CharacterBody2D


const speed: float = 20000.0


@onready
var animated_sprite = $AnimatedSprite2D
@onready
var test = $CollisionShape2D



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
		animated_sprite.animation = 'run'
	else:
		animated_sprite.animation = 'idle'


	move_and_collide(velocity * delta)
