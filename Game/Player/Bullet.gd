extends Area2D

export(int) var velocity = 400
export(bool) var rote = true
var direction = Vector2.ZERO setget set_dir

func _ready():
	pass

func set_dir(value):
	direction = value.normalized()
	if rote:
		rotation = direction.angle()
	
func _physics_process(delta):
	global_position += direction * velocity * delta
	
func _on_Timer_timeout():
	queue_free()
