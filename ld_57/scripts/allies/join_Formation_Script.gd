extends state

@export var max_Distance_From_Player : float = 48

var target_Position : Vector2

func on_State_Entered() -> void:
	super()

func on_State_Exited() -> void:
	super()

func on_State_Process() -> void:
	super()

func on_State_Physics_Process() -> void:
	super()
	
	if player_Inst.enemies_In_Range.size() > 0:
		switch_State.emit("attack", self)
	
	if global_position.distance_to(player_Inst.global_position) > max_Distance_From_Player:
		target_Position = player_Inst.global_position + (Vector2.RIGHT * (randf() * max_Distance_From_Player)).rotated(deg_to_rad(randf_range(0, 360)))
	
	if global_position.distance_to(target_Position) > 32:
		direction = global_position.direction_to(target_Position).normalized()
	else:
		target_Position = player_Inst.global_position + (Vector2.RIGHT * (randf() * max_Distance_From_Player)).rotated(deg_to_rad(randf_range(0, 360)))
