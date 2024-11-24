extends State

@export var attack_state: State
@export var move_state: State
@export var move_keys: Array[String]

func activate() -> void:
	super()
	parent.velocity.x = 0

func process_input(event: InputEvent) -> State:
	if event is InputEventKey and event.pressed:
		var action_list = InputMap.get_actions()
		for action in action_list:
			if InputMap.event_is_action(event, action):
				print("Pressed key action: ", action)
				break
	
	if Input.is_action_just_pressed('basic_attack'):
		return attack_state

	for key in move_keys:
		if Input.is_action_just_pressed(key):
			return move_state
		
	return null

func process_physics(delta: float) -> State:
	parent.move_and_collide(parent.velocity * delta)
	
	return null
