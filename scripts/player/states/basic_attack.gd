extends State

@export var move_state: State
@export var idle_state: State
@export var state_call_on_end: State

var frame_progress: float

func process_input(event: InputEvent) -> State:

	# needs to be more flexible in case some of the attacks can be performed on the move (like casting magic)
	if event is InputEventKey and event.pressed:
		for key in parent.move_keys:
			if Input.is_action_just_pressed(key):
				end_attack()
				return move_state

	return null


func process_physics(delta: float) -> State:
	parent.move_and_collide(parent.velocity * delta)
	print('starting attack')
	parent.attack_area.monitorable = true
	
	if parent.animated_sprite.get_frame_progress() != 1:
		pass
	else: 
		end_attack()
#	frame_progress = await parent.animated_sprite.get_frame_progress()
#	while frame_progress != 1:
#		pass
#	end_attack()
	
	return null


func end_attack():
	parent.attack_area.monitorable = false
	self.parent.state_machine.change_state(state_call_on_end)
