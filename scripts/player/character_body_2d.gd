extends CharacterBody2D


const max_speed: float = 300.0
const acceleration: float = 15
const deceleration: float = 10

@export var player_max_health := 100
@onready var player_current_health := player_max_health

@onready var animated_sprite = $animations
@onready var state_machine = $StateMachine

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)


func _process(delta: float) -> void:
	state_machine.process_frame(delta)


# У такого подхода есть проблема: повторная атака не регистрируется, надо что-то с этим делать
func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.visible:
		if area.is_in_group('damage'):
			print('hit for area_damage')
			area.damage = 0
			


func _on_hurt_box_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
