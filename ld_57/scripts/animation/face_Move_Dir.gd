extends Node2D

var velocity : Vector2 ## velocity of the node
var global_Position_Last : Vector2 ## position last frame, used to calculate velocity

func _physics_process(delta: float) -> void:
	velocity = global_position - global_Position_Last
	global_Position_Last = global_position
	
	look_at(global_position + velocity.normalized())
