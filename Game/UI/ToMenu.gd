extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"




func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://UI/Menu.tscn")
