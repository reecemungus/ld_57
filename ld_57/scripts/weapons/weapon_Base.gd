extends Node2D
class_name weapon

@export var icon : Texture2D ## the weapon's inventory icon

@export var is_Automatic : bool = false ## will the weapon fire as it's delay ends
@export var damage : float ## the damage dealt per hit of the weapon
@export var delay : float ## minimum cooldown between each input
@export var max_Offset : float ## maximum random offset applied to each attack

var delay_Tween : Tween ## delay handler
var can_attack : bool = true ## can the weapon be used

func on_Attack() -> bool: ## handle attack input
	if !can_attack:
		return false
	
	can_attack = false
	
	if delay_Tween:
		delay_Tween.kill()
	
	delay_Tween = create_tween()
	delay_Tween.tween_property(self, "can_attack", true, delay)
	
	return true
