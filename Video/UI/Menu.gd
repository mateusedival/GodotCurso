extends Control


func _ready():
	$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/StartButton.grab_focus()

func _on_StartButton_pressed():
	PlayerStats.refresh()
	get_tree().change_scene("res://Game.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
