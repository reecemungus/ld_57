extends Area2D
class_name bullet

var damage : float = 0
var speed : float = 256
var max_Range : float = 2048

var direction : Vector2
var travelled_Distance : float = 0.0

func _ready() -> void:
	body_entered.connect(check_Impact)
	
	direction = Vector2.RIGHT.rotated(rotation)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	travelled_Distance += speed * delta
	
	if travelled_Distance > max_Range:
		queue_free()

func check_Impact(area : PhysicsBody2D) -> void:
	queue_free()
	
	if area.has_method("take_Damage"):
		area.take_Damage(damage)
