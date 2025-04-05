extends character
class_name player

@export var speed = 300.0

var move_Direction : Vector2 ## direction of movement input

@export var current_Weapon : weapon ## currently equipped weapon
var is_Attacking : bool = false

@onready var player_Inventory_Slot : inventory = get_node("inventory") ## node containing player's weapons and inventory as children
var player_Inventory : Dictionary = {} ## reference to each item the player is holding

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	move_Direction.x = Input.get_axis("move_Left", "move_Right") ## get input
	move_Direction.y = Input.get_axis("move_Up", "move_Down")
	
	if move_Direction:
		velocity = move_Direction.normalized() * speed ## calculate velocity from move_Direction
		look_at(global_position + velocity)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed / 2) ## slow down
	
	move_and_slide() ## execute movement
