extends Node2D

var title:Label

func _ready():
	title = get_node("Header/Label")
	title.text = "Floor %s" % Main.currentFloor

func _on_ReturnButton_pressed():
	Main.play_click()
	
	Main.currentRooms = 0
	Main.currentFloor = 1
	
	Main.goto_scene("res://Scenes/Camp.tscn")

func _on_ForwardButton_pressed():
	Main.play_click()
	
	Main.currentRooms = 0
	Main.currentFloor += 1
	
	if Main.currentFloor > Main.game.maxVisitedFloor:
		Main.game.maxVisitedFloor = Main.currentFloor
	
	Main.goto_scene("res://Scenes/Game.tscn")
