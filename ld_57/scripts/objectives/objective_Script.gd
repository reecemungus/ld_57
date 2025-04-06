extends CharacterBody2D
class_name objective

signal activated

var is_Activated : bool = false

@export var activate_Health : float = 100 : 
	set(value):
		activate_Health = value
		
		if activate_Health <= 0.0 && !is_Activated:
			is_Activated = true
			
			activated.emit()
			on_Activated()

func on_Activated() -> void:
	queue_free()
