extends character
class_name player

@export var speed = 300.0

var move_Direction : Vector2 ## direction of movement input
var look_Direction : Vector2 ## direction of look input

@export var current_Weapon : weapon ## currently equipped weapon
var is_Attacking : bool = false

@onready var player_Inventory_Slot : inventory = get_node("inventory") ## node containing player's weapons and inventory as children
@onready var equipped_Slot : Node2D = get_node("equipped_Slot") ## point in space where weapons are to be held

var player_Inventory : Dictionary = {} ## reference to each item the player is holding

func _ready() -> void:
	for child in player_Inventory_Slot.get_children():
		player_Inventory[child] = false
	
	if equipped_Slot.get_children().size() > 0:
		var equipped_Weapon : weapon = equipped_Slot.get_child(0)
		
		player_Inventory[equipped_Weapon] = true

func _physics_process(delta: float) -> void:
	look_Direction.x = Input.get_axis("look_Left", "look_Right")
	look_Direction.y = Input.get_axis("look_Up", "look_Down")
	
	if look_Direction:
		look_at(global_position + look_Direction.normalized())
	
	move_Direction.x = Input.get_axis("move_Left", "move_Right") ## get input
	move_Direction.y = Input.get_axis("move_Up", "move_Down")
	
	if move_Direction:
		velocity = move_Direction.normalized() * speed ## calculate velocity from move_Direction
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed / 2) ## slow down
	
	move_and_slide() ## execute movement
	
	if current_Weapon.is_Automatic && current_Weapon.can_attack && is_Attacking:
		current_Weapon.on_Attack()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		current_Weapon.on_Attack()
		
		is_Attacking = true
	
	if event.is_action_released("attack"):
		is_Attacking = false

func switch_Weapon(target_Weapon : weapon) -> void:
	pass
