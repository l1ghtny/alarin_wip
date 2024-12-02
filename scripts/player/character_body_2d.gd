extends CharacterBody2D


const max_speed: float = 300.0
const acceleration: float = 15
const deceleration: float = 10

@export var player_max_health := 100
@export var move_keys: Array[String]
@onready var player_current_health := player_max_health

@onready var animated_sprite = $"visual things/animations"
@onready var state_machine = $StateMachine
@onready var attack_area = $attack_area

var under_attack: bool

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


func _on_hurt_box_area_entered(area: Area2D) -> void:
	under_attack = true
	pass # Replace with function body.


func _on_hurt_box_area_exited(area: Area2D) -> void:
	under_attack = false
	pass # Replace with function body.
