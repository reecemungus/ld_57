extends character
class_name ally

var target_Position : Vector2 = Vector2.ZERO
var target_Objective : objective = null

var target_Position_Offset : Vector2
var max_Offset : float = 128.0

@export var move_Speed : float = 300.0
@export var rotation_Speed : float = 2.0

@onready var player_Inst : player = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	pick_New_Target_Position()

func _physics_process(delta: float) -> void:
	if target_Objective == null:
		target_Objective = decide_Objective()
	
	if target_Objective:
		var dist_To_Obj = global_position.distance_to(target_Objective.global_position)
		
		if dist_To_Obj < 256.0 && player_Inst.aware_Bodies.has(target_Objective):
			target_Position = target_Objective.global_position
		
		if dist_To_Obj < 64:
			target_Objective.activate_Health -= delta
		
		if dist_To_Obj > 256.0 || global_position.distance_to(player_Inst.global_position) > 256:
			target_Objective = null
	
	if !target_Objective:
		if player_Inst:
			target_Position = player_Inst.global_position + target_Position_Offset
	
	var direction := (target_Position - global_position).normalized()
	var target_Angle := direction.angle()
	
	if global_position.distance_to(target_Position) > 8:
		rotation = lerp_angle(rotation, target_Angle, rotation_Speed * delta)
		velocity = Vector2.RIGHT.rotated(rotation) * move_Speed
	else:
		velocity = velocity.move_toward(Vector2.RIGHT * (move_Speed / 4), move_Speed / 32)
	
	move_and_slide()

func decide_Objective() -> objective:
	if player_Inst.aware_Bodies.size() > 0:
		for body in player_Inst.aware_Bodies:
			if body is egg:
				return body
		
		return player_Inst.aware_Bodies[randi_range(0, player_Inst.aware_Bodies.size() - 1)]
	
	return null

func pick_New_Target_Position() -> void:
	target_Position_Offset = Vector2(randf_range(-max_Offset, max_Offset), randf_range(-max_Offset, max_Offset))
	
	await create_tween().tween_interval(randf_range(2, 16)).finished
	pick_New_Target_Position()
