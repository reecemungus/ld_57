extends character
class_name player

@export var speed : float = 300.0 ## move speed
@export var rotation_Speed : float = 2.0 ## rotation speed

var move_Direction : Vector2  = Vector2.ZERO ## direction of movement input

@onready var perception : Area2D = get_node("player_Perception")
var enemies_In_Range : Array[Node2D]

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	enemies_In_Range = perception.get_overlapping_bodies()
	
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

func on_Death() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_Menu.tscn")
	
	super()
