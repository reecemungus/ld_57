extends Node2D

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/test_scene.tscn")
