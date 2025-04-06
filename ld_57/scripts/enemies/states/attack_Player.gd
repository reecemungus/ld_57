extends state

@export var collision_Damage := 4.0
var player_Character : player ## reference to player

@export var max_Distance_From_Player : float = 256
var offset : Vector2

func on_State_Entered() -> void:
	super()
	
	player_Character = get_tree().get_first_node_in_group("player")
	offset = Vector2(randf_range(-16, 16), randf_range(-16, 16))

func on_State_Exited() -> void:
	super()

func on_State_Process() -> void:
	super()

func on_State_Physics_Process(delta : float) -> void:
	super(delta)
	
	if !player_Character:
		return
	
	if player_Character:
		direction = global_position.direction_to(player_Character.global_position + offset)
	
	if global_position.distance_to(player_Character.global_position) < 24:
		player_Character.take_Damage(collision_Damage * delta)
	
	if global_position.distance_to(player_Character.global_position) > max_Distance_From_Player:
		switch_State.emit("follow_Player")
