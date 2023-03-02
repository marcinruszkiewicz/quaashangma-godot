extends Button

func _on_StartButton_pressed():
	Main.goto_scene("res://Scenes/Camp.tscn")

func _on_StartButton_mouse_entered():
	Main.play_click()
