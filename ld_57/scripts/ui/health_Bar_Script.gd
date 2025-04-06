extends TextureProgressBar

@export var player_Inst : player 

func _ready() -> void:
	player_Inst.on_Damaged.connect(update_Health_Bar)
	
	max_value = player_Inst.health
	value = player_Inst.health

func update_Health_Bar(new_Value : float) -> void:
	value = new_Value
