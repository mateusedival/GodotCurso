extends KinematicBody2D

var Bullet = load("res://Player/Bullet.tscn")
const HIT_SFX = preload("res://SFX/Player/PlayerGruntSFX.wav")
const SHOOT_SFX = preload("res://SFX/Player/ShootSFX.wav")
export(int) var SPEED = 90

export(float) var fire_rate = 0.3
var can_attack = true

var direction = Vector2.ZERO
onready var sprite = $Sprite
var stats = PlayerStats

func _ready():
	Globals.Player = self
	stats.connect("dead",self,"_on_Stats_dead")

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
	SfxHandler.play_sfx(SHOOT_SFX)
	
func _on_Timer_timeout():
	can_attack = true
	
func _on_Stats_dead():
	$AnimationPlayer.play("Death")
	set_physics_process(false)

func _on_Hurtbox_area_entered(hitbox):
	stats.health -= hitbox.damage
	$Hurtbox.start_invincibility(0.4)
	
	if(stats.health >= 1 ):
		$AnimationPlayer.play("Damage")
		SfxHandler.play_sfx(HIT_SFX,Vector2(1.5,1.7))

func _on_game_over():
	get_tree().change_scene("res://UI/GameOver.tscn")
	
