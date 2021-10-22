extends StaticBody2D

export(String) var scene_to_change





func _on_AnimatedSprite_animation_finished():
	get_tree().change_scene(scene_to_change)


func _on_Area2D_body_entered(body):
	$AnimatedSprite.play("Open")
