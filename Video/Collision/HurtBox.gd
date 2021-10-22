extends Area2D

var invincible = false setget set_invincible

signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")


func _on_Timer_timeout():
	self.invincible = false

func start_invincibility(duration: float):
	self.invincible = true
	$Timer.start(duration)
	



func _on_HurtBox_invincibility_ended():
	$CollisionShape2D.disabled = false


func _on_HurtBox_invincibility_started():
	$CollisionShape2D.set_deferred("disabled",true)
