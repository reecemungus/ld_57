extends Node

var ambience_Files : String = "res://assets/audio/ambience/"
var ambience : Array = []

var death_Sound_Files : String = "res://assets/audio/enemy_Deaths/"
var death_Sounds : Array = []

func _ready() -> void:
	var files = ResourceLoader.list_directory(ambience_Files)
	
	for file in files:
		var sound_Effect : String = ambience_Files + file
		ambience.append(load(sound_Effect))
	
	play_Ambience()
	
	var death_Files = ResourceLoader.list_directory(death_Sound_Files)
	
	for file in death_Files:
		var sound_Effect : String = death_Sound_Files + file
		death_Sounds.append(load(sound_Effect))

func play_Ambience() -> void:
	var new_Sound : AudioStream = ambience[randi_range(0, ambience.size() - 1)]
	
	var new_Player := AudioStreamPlayer.new()
	new_Player.stream = new_Sound
	new_Player.pitch_scale = randf_range(0.8, 1.2)
	new_Player.volume_linear = randf_range(0.05, 0.4)
	
	add_child(new_Player)
	
	new_Player.playing = true
	new_Player.finished.connect(new_Player.queue_free)
	
	await create_tween().tween_interval(randf_range(8, 32)).finished
	play_Ambience()

func play_Death_Sound() -> void:
	var new_Sound : AudioStream = death_Sounds[randi_range(0, death_Sounds.size() - 1)]
	
	var new_Player := AudioStreamPlayer.new()
	new_Player.stream = new_Sound
	new_Player.pitch_scale = randf_range(0.8, 1.2)
	new_Player.volume_linear = randf_range(0.05, 0.6)
	
	add_child(new_Player)
	
	new_Player.playing = true
	new_Player.finished.connect(new_Player.queue_free)

func playSound(sound : AudioStream) -> void:
	var new_Player := AudioStreamPlayer.new()
	new_Player.stream = sound
	
	new_Player.stream = sound
	new_Player.pitch_scale = randf_range(0.8, 1.2)
	new_Player.volume_linear = randf_range(0.05, 0.6)
	
	add_child(new_Player)
	
	new_Player.playing = true
	new_Player.finished.connect(new_Player.queue_free)
