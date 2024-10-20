extends Camera2D
@export var player: CharacterBody2D
var smoothing_speed := 160.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = global_position.lerp(player.global_position, smoothing_speed * delta)
