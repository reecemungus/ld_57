extends state

var player_Character : player ## reference to player

func on_State_Entered() -> void:
	super()
	
	player_Character = get_tree().get_first_node_in_group("player")

func on_State_Exited() -> void:
	super()

func on_State_Process() -> void:
	super()

func on_State_Physics_Process() -> void:
	super()
	
	if player_Character:
		direction = global_position.direction_to(player_Character.global_position)
