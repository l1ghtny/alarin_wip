extends CharacterBody2D


signal direction_changed(new_direction: Vector2)

const max_speed: float = 300.0
const acceleration: float = 15
const deceleration: float = 10

@export var player_max_health := 100
@export var move_keys: Array[String]

@onready var player_current_health := player_max_health
@onready var animated_sprite = $"visual things/animations"
@onready var state_machine = $StateMachine
@onready var attack_area = $Interactions/HitBox

var cardinal_direction: Vector2 = Vector2.RIGHT
var direction: Vector2 = Vector2.ZERO


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can act on player's behalf
	state_machine.init(self)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	


func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
	
func set_direction() -> bool:
	var new_dir: Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
		
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	print('direction changed')
	direction_changed.emit(new_dir)
	
	return true
	
	