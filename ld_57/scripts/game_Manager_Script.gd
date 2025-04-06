extends Node2D

@export var max_Egg_Dist : float = 1920.0
@export var min_Egg_Dist : float = 960.0

@export var max_Enemies : int
var enemies : Array = []

var current_Egg : objective = null
var time_Elapsed : float = 0.0

@onready var player_Inst : player = get_tree().get_first_node_in_group("player")
@onready var objective_Marker : Line2D = get_node("objective_Marker")

func _ready() -> void:
	spawn_Egg()
	spawn_Enemy()

func _physics_process(delta: float) -> void:
	time_Elapsed += delta
	
	enemies = get_tree().get_nodes_in_group("enemy")
	
	if player_Inst && current_Egg:
		objective_Marker.points[0] = objective_Marker.to_local(player_Inst.global_position)
		objective_Marker.points[1] = objective_Marker.to_local(current_Egg.global_position)

func spawn_Egg() -> void:
	var new_Egg := preload("res://scenes/allies/egg.tscn").instantiate()
	
	var radius := randf_range(min_Egg_Dist, max_Egg_Dist)
	var angle := randf_range(0, TAU)
	var offset := Vector2(cos(angle), sin(angle)) * radius
	
	new_Egg.global_position = player_Inst.global_position + offset
	
	var root_Node := get_node("/root")
	root_Node.call_deferred("add_child", new_Egg)
	
	current_Egg = new_Egg
	current_Egg.activated.connect(spawn_Egg)

func spawn_Enemy() -> void:
	var difficulty := time_Elapsed * 0.05
	
	for i in range(1 + ceil(difficulty)):
		if enemies.size() > max_Enemies:
			break
		
		var new_Enemy := preload("res://scenes/enemies/enemy.tscn").instantiate()
		
		var radius := randf_range(min_Egg_Dist, max_Egg_Dist)
		var angle := randf_range(0, TAU)
		var offset := Vector2(cos(angle), sin(angle)) * radius
		
		new_Enemy.global_position = player_Inst.global_position + offset
		
		new_Enemy.get_node("enemy").activate_Health += difficulty * 0.1
		new_Enemy.get_node("enemy").damage += difficulty * 0.1
		new_Enemy.get_node("enemy").move_Speed += difficulty * 0.1
		
		var root_Node := get_node("/root")
		root_Node.call_deferred("add_child", new_Enemy)
	
	await create_tween().tween_interval(randf_range(2.0, 8.0)).finished
	spawn_Enemy()
