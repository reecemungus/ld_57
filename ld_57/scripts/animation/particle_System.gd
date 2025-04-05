extends Line2D
class_name particle_System

@onready var system_Length : float = points[0].distance_to(points[points.size() - 1]) ## the total length of the system, calculated on ready

var global_Points : PackedVector2Array ## each point's position in world space
var prev_points : PackedVector2Array ## each point's position last frame

func _ready() -> void:
	global_Points = points.duplicate() ## copy points from initialised line
	
	for index in range(points.size()): ## convert them to global space
		global_Points[index] = to_global(points[index])
	
	prev_points = global_Points.duplicate() ## copy global points


func _physics_process(delta: float) -> void:
	if global_Points.size() == 0:
		return
	
	verlet_Integration(delta)
	
	set_deferred("global_Points[0]", global_position)
	call_deferred("update_Line") ## update the line at the end of the frame

func verlet_Integration(delta : float) -> void: ## TODO - comment
	for i in range(global_Points.size()):
		if i == 0:
			continue
		
		var temp := global_Points[i]
		var velocity := (global_Points[i] - prev_points[i]) * 0.95
		
		global_Points[i] += velocity # + Vector2(0, 980 * delta * delta) ## 
		prev_points[i] = temp

func update_Line() -> void:
	for index in range(global_Points.size()):
		if index == 0:
			points[index] = Vector2.ZERO
			continue
		
		points[index] = to_local(global_Points[index])
