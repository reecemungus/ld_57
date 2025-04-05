extends character
class_name player

@export var speed : float = 300.0
@export var input_Multiplier : float = 2.5

@export var rotation_Speed : float = 25.0

var move_Direction : Vector2  = Vector2.ZERO ## direction of movement input

@onready var head_Sprite : Sprite2D = get_node("head")
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
	
	var speed_Multiplier := speed + (move_Direction.normalized().y * input_Multiplier)
	velocity = Vector2.RIGHT.rotated(rotation) * speed_Multiplier
	
	move_and_slide() ## execute movement
