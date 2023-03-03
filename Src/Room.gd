extends NinePatchRect

var visited:TextureRect
var exit:TextureRect
var image:TextureRect
var gameScene

export var destination = 0
var room_type = "empty"
var description = ""

func _ready():
	visited = get_node("Visited")
	exit = get_node("Exit")
	image = get_node("Image")
	gameScene = get_parent()
	image.visible = false

func _on_RoomButton_mouse_entered():
	image.self_modulate = Color(0.9, 0.9, 0, 0.2)

func _on_RoomButton_mouse_exited():
	image.self_modulate = Color(1, 1, 1, 1)

func _on_RoomButton_pressed():
	Main.play_click()
	visitRoom()

func initRoom(type):
	room_type = type
	var rnd = randi() % 3
	image.texture = load("res://Assets/rooms/%s/%s.png" % [room_type, rnd])
	image.visible = true
	
	var desc_array = Main.descriptions.room_descriptions[room_type]
	description = desc_array[randi() % desc_array.size()]
	
func clearRoom():
	image.visible = false
	visited.visible = false
	exit.visible = false
	
func visitRoom():
	var forward_button = get_node("/root/Game/ForwardButton")
	var room_description = ""
	var isvisited = gameScene.floorplan.is_visited(Main.currentRooms, destination)
	forward_button.visible = false
	
	if isvisited:
		room_description += "There's nothing here anymore."
	else:
		gameScene.floorplan.mark_visited(Main.currentRooms, destination)
		visited.visible = true
		
		room_description += description
		match(room_type):
			"monster":
				var hp_loss = randi() % (Main.currentFloor + randi() % 5)
				Main.game.HP -= hp_loss
				gameScene.update_stats()
				
				if Main.game.HP <= 0:
					Main.goto_scene("res://Scenes/YouDied.tscn")
				else:
					room_description += "\nYou manage to defeat the monsters."
				
				var drop_chance = randi() % 31
				if drop_chance <= 10:
					room_description += "\nOne of the monsters drops a healing potion."
					if Main.game.HP + 5 >= Main.game.maxHP:
						Main.game.HP = Main.game.maxHP
					else:
						Main.game.HP += 5
					gameScene.update_stats()
			"trap":
				var avoid_chance = randi() % 100
				
				if avoid_chance <= 50:
					room_description += "\nYou manage to avoid the trap."
				else:					
					var hp_loss = randi() % (Main.currentFloor + randi() % 4)
					Main.game.HP -= hp_loss
					gameScene.update_stats()
					if Main.game.HP <= 0:
						Main.goto_scene("res://Scenes/YouDied.tscn")
					else:
						if hp_loss == 0:
							room_description += "\nYou easily avoid the trap."
						else:
							room_description += "\nThe trap has taken %s HP from you." % hp_loss
			"treasure":
				var gold = randi() % (Main.currentFloor + randi() % 4)
				Main.game.gold += gold
				gameScene.update_stats()
				
				if gold == 0:
					room_description += "\nSadly nothing in this room has any value."
				else:
					room_description += "\nYou find %s gold worth of treasure." % gold
			"empty":
				pass
			"exit":
				pass
	
	if gameScene.floorplan.is_exit(Main.currentRooms, destination):
		forward_button.visible = true
		exit.visible = true
		room_description += "\nYou can explore further from here."
	
	gameScene.update_description(room_description)	
	
