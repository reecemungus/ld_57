extends weapon
class_name gun

@export var bullet_Scene : PackedScene
@export var bullet_Count : int = 1
@export var bullet_Speed_Variation : float = 0.0

@onready var range_Area : Area2D = get_node("range_Area")
@onready var barrel : Node2D = get_node("sprite/barrel")

var target : enemy_Base = null

func _physics_process(delta: float) -> void:
	var pot_Targets := range_Area.get_overlapping_bodies()
	
	if pot_Targets.size() > 0:
		target = pot_Targets.front()
		
		look_at(target.global_position)
		on_Attack()

func on_Attack() -> bool:
	if !super(): ## handle input
		return false
	
	for i in range(bullet_Count):
		var new_Bullet : bullet = bullet_Scene.instantiate()
		new_Bullet.global_position = barrel.global_position
		new_Bullet.global_rotation = barrel.global_rotation
		
		new_Bullet.damage = damage
		new_Bullet.speed += randf_range(-bullet_Speed_Variation, bullet_Speed_Variation)
		new_Bullet.rotate(randf_range(-max_Offset, max_Offset))
		
		get_node("/root").add_child(new_Bullet)
	
	return true
