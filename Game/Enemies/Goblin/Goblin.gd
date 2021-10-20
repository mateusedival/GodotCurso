extends KinematicBody2D

export(int) var SPEED = 50
var direction = Vector2.ZERO
onready var player = Globals.Player
onready var sprite = $AnimatedSprite
var knockback =  Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	
	knockback = knockback.move_toward(Vector2.ZERO, delta * 400)
	knockback = move_and_slide(knockback)
	
	if(PlayerStats.health > 0):
		direction = global_position.direction_to(player.global_position)
	else:
		direction = Vector2.ZERO
	
	var velocity = direction * SPEED
	
	velocity = move_and_slide(velocity)
	
	if(direction != Vector2.ZERO):
		sprite.play("Run")
	else:
		sprite.play("Idle")
		
	sprite.flip_h = direction.x < 0
	


func _on_Stats_dead():
	queue_free()

func _on_Hurtbox_area_entered(hitbox):
	$Stats.health -= hitbox.damage
	knockback = global_position.direction_to(hitbox.global_position) * -70
	$Hurtbox.start_invincibility(0.2)
	$AnimationPlayer.play("Damage")
