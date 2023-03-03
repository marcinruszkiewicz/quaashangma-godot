extends Node2D

var title:Label

func _ready():
	title = get_node("Header/Label")
	title.text = "Floor %s" % Main.currentFloor

func _on_Button_pressed():
	Main.play_click()
	
	Main.game.gold = 0
	Main.currentRooms = 0
	Main.currentFloor = 1
	
	Main.goto_scene("res://Scenes/Camp.tscn")
