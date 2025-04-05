extends Path2D

@export var enemies : Array[PackedScene] = []
var enemy_Insts : Array[non_Player_Character] = []

@onready var follower : PathFollow2D = get_node("follower")

func _ready() -> void:
	for i in range(25):
		call_deferred("spawn_Enemy")

func _physics_process(delta: float) -> void:
	for i in range(enemies.size()):
		if enemies[i] == null:
			pass

func spawn_Enemy() -> void:
	follower.progress_ratio = randf()
	
	var new_Enemy := enemies[0].instantiate()
	new_Enemy.global_position = follower.global_position
	
	enemy_Insts.append(new_Enemy)
	get_node("/root").add_child(new_Enemy)
