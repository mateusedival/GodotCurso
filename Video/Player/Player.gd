extends KinematicBody2D


export(int) var SPEED = 90
var direction = Vector2.ZERO

onready var sprite = $Sprite

var Bullet = load("res://Player/Bullet.tscn")

export(float) var fire_rate = 0.3 
var can_attack = true

func _ready():
	Globals.Player = self

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
	
	if Input.is_action_pressed("ui_attack") and can_attack:
		shoot()
		
func shoot():
	var bullet = Bullet.instance()
	bullet.global_position = global_position
	bullet.direction = global_position.direction_to(get_global_mouse_position())
	get_tree().current_scene.add_child(bullet)
	can_attack = false
	$Timer.start(fire_rate)
		


func _on_Timer_timeout():
	can_attack = true
