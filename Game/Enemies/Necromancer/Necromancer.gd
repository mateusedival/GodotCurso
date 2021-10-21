extends KinematicBody2D

var Bullet = load("res://Enemies/Necromancer/NecromancerBullet.tscn")
const HIT_SFX = preload("res://SFX/Necromancer/NecromanceGruntSFX.wav")
const TOSS_SFX = preload("res://SFX/Necromancer/TossSFX.mp3")

export(int) var SPEED = 40
onready var direction: Vector2 
export(int) var distance = 175
var initial_position
var flip: bool = false
onready var sprite = $AnimatedSprite
var knockback = Vector2.ZERO
var can_shoot = true
var fire_rate = 0.8
onready var time = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2.LEFT
	initial_position = global_position
	
func _physics_process(delta):
	
	knockback = knockback.move_toward(Vector2.ZERO, delta * 400)
	knockback = move_and_slide(knockback)
	
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
		
	var aim = $Range.get_overlapping_bodies()
	
	if (can_shoot and aim):
		shoot( global_position.direction_to(aim[0].global_position))
	
	
func shoot(shoot_direction):
	var bullet = Bullet.instance()
	bullet.direction = shoot_direction
	bullet.global_position = global_position 
	get_tree().current_scene.add_child(bullet)
	$Timer.start(fire_rate)
	can_shoot = false
	SfxHandler.play_sfx(TOSS_SFX)
	
func _on_Stats_dead():
	queue_free()


func _on_Hurtbox_area_entered(hitbox):
	$Stats.health -= hitbox.damage
	knockback = global_position.direction_to(hitbox.global_position) * -90
	$Hurtbox.start_invincibility(0.2)
	SfxHandler.play_sfx(HIT_SFX,Vector2(0.7,1.2))
	$AnimationPlayer.play("Damage")


func _on_Range_body_entered(body):
	print(body)


func _on_Timer_timeout():
	can_shoot = true
