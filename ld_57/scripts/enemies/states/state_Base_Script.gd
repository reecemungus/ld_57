extends Node2D
class_name state

signal switch_State(to_State : String, from_State : state) 

var is_Active : bool

var target_Position : Vector2 ## direction to move the enemy

@export var speed : float  = 200 ## speed that the enemy will move with while in this state
@export var rotation_Speed : float  = 2.0 ## rotation speed

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

func on_State_Physics_Process(delta : float) -> void:
	pass
