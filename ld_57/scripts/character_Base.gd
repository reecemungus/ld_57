extends CharacterBody2D
class_name character

signal on_Damaged(health : float)

@export var health : float = 100.0 : 
	set(value):
		health = value
		on_Damaged.emit(health)
		
		if health <= 0 && !is_Dead:
			is_Dead = true
			on_Death()

var is_Dead : bool = false
@export var health_Regen : float = 0.0

func _physics_process(delta: float) -> void:
	health += health_Regen * delta

func take_Damage(damage : float) -> void:
	health -= damage

func on_Death() -> void:
	get_node("..").queue_free()
