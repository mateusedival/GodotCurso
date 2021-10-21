extends KinematicBody2D

export(int) var velocity = 400
export(bool) var rote = true
var direction = Vector2.ZERO setget set_dir

func _ready():
	pass

func set_dir(value):
	direction = value.normalized()
	if rote:
		rotation = direction.angle() + deg2rad(90)
		
	
func _physics_process(delta):
	var collision = move_and_collide(direction * velocity * delta)
	if collision:
		queue_free()
	
func _on_Timer_timeout():
	queue_free()

