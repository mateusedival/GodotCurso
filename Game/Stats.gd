extends Node


export(int) var max_health = 1 setget set_max_health
var health = max_health setget set_health

signal dead

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)

func set_health(value):
	health = value
	if(health <= 0 ):
		emit_signal("dead")

func _ready():
	self.health = max_health
