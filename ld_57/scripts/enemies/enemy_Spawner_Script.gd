extends Path2D

@export var max_Enemies : int = 6
@export var enemies : Array[PackedScene] = []
var enemy_Insts : Array[Node] = []

@onready var follower : PathFollow2D = get_node("follower")

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	enemy_Insts = get_tree().get_nodes_in_group("enemy_Inst")
	
	if enemy_Insts.size() < max_Enemies:
		spawn_Enemy()
	
	enemy_Insts.clear()

func spawn_Enemy() -> void:
	follower.progress_ratio = randf()
	
	var new_Enemy := enemies[0].instantiate()
	new_Enemy.global_position = follower.global_position
	
	get_node("/root").add_child(new_Enemy)
