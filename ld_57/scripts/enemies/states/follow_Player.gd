extends state

@export var max_Radius_From_Player : float = 48
var target_Position : Vector2

func on_State_Entered() -> void:
	super()
	
	if player_Inst:
		target_Position = player_Inst.global_position + ((Vector2.RIGHT * randf_range(-max_Radius_From_Player, max_Radius_From_Player)).rotated(deg_to_rad(randf_range(0, 360))))

func on_State_Exited() -> void:
	super()

func on_State_Process() -> void:
	super()

func on_State_Physics_Process(delta : float) -> void:
	super(delta)
	
	if !player_Inst:
		return
	
	if player_Inst && target_Position:
		direction = global_position.direction_to(target_Position)
		
		if global_position.distance_to(target_Position) < 8:
			switch_State.emit("attack_Player")
