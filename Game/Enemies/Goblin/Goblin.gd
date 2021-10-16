extends KinematicBody2D

export(int) var SPEED = 50
var direction = Vector2.ZERO
onready var player = Globals.Player
onready var sprite = $AnimatedSprite

func _ready():
	print(player)

func _physics_process(delta):
	
	if(player != null):
		direction = global_position.direction_to(player.global_position)
	
	var velocity = direction * SPEED
	
	velocity = move_and_slide(velocity)
	
	if(direction != Vector2.ZERO):
		sprite.play("Run")
	else:
		sprite.play("Idle")
		
	sprite.flip_h = direction.x < 0
	
	
