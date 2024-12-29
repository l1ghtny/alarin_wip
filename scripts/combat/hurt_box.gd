class_name HurtBox
extends Area2D


@export var damage: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(on_area_entered)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func on_area_entered(area2d: Area2D):
	if area2d is HitBox:
		area2d.take_damage(damage)
	else:
		pass
	
