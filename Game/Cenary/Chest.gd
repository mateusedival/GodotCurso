extends StaticBody2D

export(String) var scene_to_change


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	$AnimatedSprite.play("Open")
	


func _on_AnimatedSprite_animation_finished():
	get_tree().change_scene(scene_to_change)
