extends KinematicBody2D

export(int) var SPEED = 40
onready var direction: Vector2 
export(int) var distance = 175
var initial_position
var flip: bool = false
onready var sprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2.LEFT
	initial_position = global_position
	
func _process(delta):
	var velocity = direction * SPEED
	
	var collide = move_and_collide(velocity * delta)
	
	if collide:
		direction *= -1
		flip = !flip		
	
	if(direction != Vector2.ZERO):
		sprite.play("Run")
	else:
		sprite.play("Idle")
	
	
	sprite.flip_h = direction.x < 0
	
	if global_position.x < initial_position.x - distance and !flip:
		direction = Vector2.RIGHT
		flip = true
	elif global_position.x > initial_position.x + distance and flip:
		direction= Vector2.LEFT
		flip = false
	
	
	
