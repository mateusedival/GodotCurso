extends KinematicBody2D

export(int) var velocity = 400
var direction = Vector2.ZERO setget set_dir

export(bool) var rote = true

func set_dir(value):
	direction = value.normalized()
	if rote:
		rotation = direction.angle()
	
func _physics_process(delta):
	
	var collision = move_and_collide(direction * velocity * delta)
	
	if collision:
		queue_free()


func _on_Timer_timeout():
	queue_free()
	
	
