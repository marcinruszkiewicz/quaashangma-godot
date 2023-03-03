extends NinePatchRect

var gameScene

func _ready():
	gameScene = get_parent()

func _on_Button_pressed():
	Main.play_click() 
	
	if gameScene.floorplan.is_last_set(Main.currentRooms):
		Main.goto_scene("res://Scenes/FloorTransition.tscn")
	else:
		Main.currentRooms += 1
		gameScene.init_rooms()
		
