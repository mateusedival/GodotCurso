extends KinematicBody2D

export(int) var SPEED = 40
onready var direction: Vector2
var distance = 100
var initial_position
var flip: bool = false
onready var sprite = $AnimatedSprite


var Bullet = load("res://Enemies/Necromancer/NecromancerBullet.tscn")
var can_shoot = true
export(float) var fire_rate = 0.3 

func _ready():
	direction = Vector2.LEFT
	initial_position = global_position

func _physics_process(delta):
	var velocity = direction * SPEED
	velocity = move_and_slide(velocity)
	
	var collide = move_and_collide(velocity * delta)
	
	if collide:
		direction *= -1
		flip = !flip
	
	if direction != Vector2.ZERO:
		sprite.play("Run")
	else:
		sprite.play("Idle")
	
	sprite.flip_h = direction.x < 0
	
	if global_position.x < initial_position.x - distance and !flip:
		direction = Vector2.RIGHT
		flip = true
	elif global_position.x > initial_position.x + distance and flip:
		direction = Vector2.LEFT
		flip = false

	var aim = $Range.get_overlapping_bodies()
	
	if(can_shoot and aim):
		shoot(global_position.direction_to(aim[0].global_position))


func shoot(shoot_direction):
	var bullet = Bullet.instance()
	bullet.direction = shoot_direction
	bullet.global_position = global_position
	get_tree().current_scene.add_child(bullet)
	$Timer.start(fire_rate)
	can_shoot = false
	

func _on_Timer_timeout():
	can_shoot = true
