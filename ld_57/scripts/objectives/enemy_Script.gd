extends objective

@export var move_Speed : float = 300.0
@export var rotation_Speed : float = 8.0
@export var damage : float = 6.0

var target : character
var target_Position : Vector2

func _ready() -> void:
	find_Target()

func _physics_process(delta: float) -> void:
	if target == null:
		find_Target()
		return
	
	var dist_To_Obj = global_position.distance_to(target.global_position)
	target_Position = target.global_position
	
	if dist_To_Obj < 16:
		target.take_Damage(damage * delta)
	
	var direction := (target_Position - global_position).normalized()
	var target_Angle := direction.angle()
	
	if global_position.distance_to(target_Position) > 8:
		rotation = lerp_angle(rotation, target_Angle, rotation_Speed * delta)
		velocity = Vector2.RIGHT.rotated(rotation) * move_Speed
	else:
		velocity = velocity.move_toward(Vector2.RIGHT * (move_Speed / 4), move_Speed / 32)
	
	move_and_slide()

func find_Target() -> void:
	var player_Team := get_tree().get_nodes_in_group("player_Team")
	
	if player_Team.size() > 0:
		target = player_Team[randi_range(0, player_Team.size() - 1)]

func on_Activated() -> void:
	SoundManager.play_Death_Sound()
	get_node("..").queue_free()
