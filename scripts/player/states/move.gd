extends State

@export var attack_state: State
@export var idle_state: State

const VELOCITY_THRESHOLD: float = 1  # Very small threshold for considering velocity as zero



# Called when the node enters the scene tree for the first time.
func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed('basic_attack'):
		return attack_state
	return null
	
func process_physics(delta: float) -> State:
	#	# Get the input direction and handle the movement/deceleration.
	var left := Input.is_action_pressed("move_left")
	var right := Input.is_action_pressed("move_right")
	var up := Input.is_action_pressed("move_up")
	var down := Input.is_action_pressed("move_down")
 
	var target_direction := Vector2(int(right) - int(left), int(down) - int(up)).normalized()
	
	if target_direction != Vector2.ZERO:
		parent.velocity = parent.velocity.lerp(target_direction * parent.max_speed, parent.acceleration * delta)
	else:
		parent.velocity = parent.velocity.lerp(Vector2.ZERO, parent.deceleration * delta)
		
		if abs(parent.velocity.x) < VELOCITY_THRESHOLD and abs(parent.velocity.y) < VELOCITY_THRESHOLD:
			parent.velocity = Vector2.ZERO
		
	if parent.velocity.x > 0:
		parent.animated_sprite.flip_h = false
	else:
		parent.animated_sprite.flip_h = true
	
	
	parent.move_and_slide()
	
	if parent.velocity:
		return null
	else:
		return idle_state



	
