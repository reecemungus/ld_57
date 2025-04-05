extends particle_System
class_name tail

@export var parent : Node2D
var offset : Vector2

@export var iterations : int = 8

func _ready() -> void:
	super()
	
	if parent:
		offset = global_position - parent.global_position

func _physics_process(delta: float) -> void:
	super(delta)
	
	solve_Pos_Gauss_Seidel()
	
	if parent:
		#var target_Pos := parent.global_position + offset.rotated(parent.global_rotation)
		var target_Pos := parent.to_global(offset)
		
		global_position = target_Pos
		global_Points[0] = target_Pos

func solve_Pos_Gauss_Seidel() -> void:
	var segment_Length := (system_Length / (global_Points.size() - 1)) ## get length of each segment TODO - move to only calculate once
	
	for iteration in iterations: ## iterations
		for i in range(global_Points.size()): ## i is point index
			if i == 0: ## do not move base
				global_Points[0] = global_position ## set base to correct position
				continue
			
			var distance := global_Points[i].distance_to(global_Points[i - 1]) ## get distance to previous point
			
			if distance != 0:
				var diff = (global_Points[i] - global_Points[i - 1]).normalized() * (distance - segment_Length)
				
				global_Points[i] -= diff / 2
				
				if i - 1 != 0:
					global_Points[i - 1] += diff / 2
