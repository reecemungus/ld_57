extends state

@export var collision_Damage : float = 4
var target_Enemy : non_Player_Character

func on_State_Entered() -> void:
	super()

func on_State_Exited() -> void:
	super()

func on_State_Process() -> void:
	super()

func on_State_Physics_Process(delta) -> void:
	super(delta)
	
	if !player_Inst:
		return
	
	if player_Inst.enemies_In_Range.size() <= 0:
		switch_State.emit("join_Formation", self)
		return
	
	elif target_Enemy == null:
		target_Enemy = player_Inst.enemies_In_Range[randi_range(0, player_Inst.enemies_In_Range.size() - 1)]
	
	if global_position.distance_to(target_Enemy.global_position) < 8:
		target_Enemy.take_Damage(collision_Damage * delta)
	
	#direction = global_position.direction_to(target_Enemy.global_position)
