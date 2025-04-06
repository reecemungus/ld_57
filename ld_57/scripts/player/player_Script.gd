extends character
class_name player

@export var speed : float = 300.0 ## move speed
@export var rotation_Speed : float = 2.0 ## rotation speed

var move_Direction : Vector2  = Vector2.ZERO ## direction of movement input

@onready var perception : Area2D = get_node("player_Perception")

var aware_Bodies : Array[Node2D]
var aware_Enemies : Array[objective]
var aware_Eggs : Array[objective]

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	super(delta)
	
	handle_Prio()
	
	move_Direction.x = Input.get_axis( "move_Right", "move_Left") ## get input
	move_Direction.y = Input.get_axis("move_Down", "move_Up")
	
	var rotation_Multiplier := rotation_Speed * move_Direction.normalized().x
	rotate(deg_to_rad(-rotation_Multiplier))
	
	var speed_Multiplier := move_Direction.normalized().y * speed
	
	if speed_Multiplier > 0:
		velocity = Vector2.RIGHT.rotated(rotation) * speed_Multiplier
	else:
		velocity = velocity.move_toward(Vector2.RIGHT.rotated(rotation) * (speed / 2), speed / 64)
	
	move_and_slide() ## execute movement

func handle_Prio() -> void:
	aware_Bodies.clear()
	aware_Bodies = perception.get_overlapping_bodies() ## get all percieved bodies

func on_Death() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_Menu.tscn")
	
	super()
