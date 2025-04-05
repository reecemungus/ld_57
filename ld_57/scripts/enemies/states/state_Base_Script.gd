extends Node2D
class_name state

signal switch_State(to_State : String, from_State : state) 

var is_Active : bool

var direction : Vector2 ## direction to move the enemy
@export var speed : float ## speed that the enemy will move with while in this state

@onready var player_Inst : player = get_tree().get_first_node_in_group("player")

func on_State_Entered() -> void:
	print("entering %s" % self.name)
	
	is_Active = true
	pass

func on_State_Exited() -> void:
	print("exiting %s" % self.name)
	
	is_Active = false
	pass

func on_State_Process() -> void:
	pass

func on_State_Physics_Process() -> void:
	pass
