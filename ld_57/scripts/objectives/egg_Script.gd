extends objective
class_name egg

func on_Activated() -> void:
	var new_Fish := preload("res://scenes/allies/spear_fish.tscn").instantiate()
	new_Fish.global_position = global_position
	
	get_node("/root").add_child(new_Fish)
	SoundManager.playSound(preload("res://assets/audio/hatch.wav"))
	
	super()
