extends state

func on_State_Entered() -> void:
	super()

func on_State_Exited() -> void:
	super()

func on_State_Process() -> void:
	super()

func on_State_Physics_Process() -> void:
	super()
	
	if player_Inst.enemies_In_Range.size() <= 0:
		switch_State.emit("join_Formation", self)
		return
	
	direction = global_position.direction_to(player_Inst.enemies_In_Range[0].global_position)
