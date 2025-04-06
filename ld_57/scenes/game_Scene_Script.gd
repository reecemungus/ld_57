extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemies := get_tree().get_nodes_in_group("enemy")
	var fish := get_tree().get_nodes_in_group("player_Team")
	
	for item in enemies:
		item.queue_free()
	
	for item in fish:
		if item is not player:
			item.queue_free()
	
	var new_Fish := preload("res://scenes/allies/spear_fish.tscn").instantiate()
	add_child(new_Fish)
