extends character
class_name non_Player_Character

@export var default_State : state ## the state that the enemy will spawn in
var states : Dictionary = {} ## contains all possible states for the enemy
var current_State : state ## the current state that is controlling the enemy

func _ready() -> void:
	for child in get_children():
		if child is state: ## get all children of the enemy that are states
			states[child.name] = child ## add to the state dictionary
			child.switch_State.connect(on_Switch_State)
	
	on_Switch_State(default_State.name)

func _process(delta: float) -> void:
	if !current_State: ## if there is no active state, back out
		return
	
	current_State.on_State_Process() ## run state code

func _physics_process(delta: float) -> void:
	if !current_State: ## if there is no active state, back out
		return
	
	current_State.on_State_Physics_Process() ## run state code
	
	if current_State.direction != Vector2.ZERO:
		velocity = current_State.direction.normalized() * current_State.speed ## move toward the location that the state suggests
		look_at(global_position + velocity) ## face move direction
	
	move_and_slide() ## execute movement

func on_Switch_State(to_State : String, from_State : state = null) -> void:
	if from_State:
		from_State.on_State_Exited()
	
	var new_State : state = states[to_State]
	current_State = new_State
	
	new_State.on_State_Entered()
