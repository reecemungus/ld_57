extends CharacterBody2D
class_name character

@export var health : float = 100.0 : 
	set(value):
		health = value
		
		if health <= 0:
			on_Death()

func take_Damage(damage : float) -> void:
	health -= damage
	print(damage)

func on_Death() -> void:
	queue_free()
