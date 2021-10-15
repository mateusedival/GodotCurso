extends KinematicBody2D


export(int) var SPEED = 80

var direction = Vector2.ZERO
onready var sprite = $Sprite



func _physics_process(delta):
	var input = Vector2.ZERO
	
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	direction = input.normalized()
	
	direction = move_and_slide(direction * SPEED)
	
	if direction == Vector2.ZERO:
		sprite.play("Idle")
	else:
		sprite.play("Run")
	
	sprite.flip_h = direction.x < 0
