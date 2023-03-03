extends NinePatchRect

var gameScene

func _ready():
	gameScene = get_parent()

func _on_Button_pressed():
	Main.play_click() 
	
	if gameScene.floorplan.is_last_set(Main.currentRooms):
		# exiting the dungeon floor, show transition screen
		pass
	else:
		Main.currentRooms += 1
		gameScene.init_rooms()
		
