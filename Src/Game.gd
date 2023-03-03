extends Node2D

var HP:Label
var Gold:Label
var description:Label
var title:Label

var rooms = Array()
var room_types = ["empty", "monster", "trap", "treasure", "exit"]
var floorplan

func _ready():
	title = get_node("Header/Label")
	HP = get_node("StatsBackground/HP")
	Gold = get_node("StatsBackground/Gold")
	description = get_node("Description/Label")
	rooms.append(get_node("RoomTop"))
	rooms.append(get_node("RoomLeft"))
	rooms.append(get_node("RoomBottom"))
	rooms.append(get_node("RoomRight"))
	
	init_dungeon()	
	init_rooms()
	
	title.text = "Floor %s" % Main.currentFloor
	description.text = "You're standing in a dungeon. There are rooms on all sides, but which one should you choose?"

	update_stats()
	
func update_stats():
	Gold.text = "Gold: %s" % Main.game.gold
	HP.text = "HP: %s/%s" % [Main.game.HP, Main.game.maxHP]

func update_description(text):	
	description.text = text
	
func init_dungeon():
	var factory = load("res://Src/DungeonFloor.gd")
	floorplan = factory.new(Main.currentFloor)
	
func init_rooms():	
	var room_set = floorplan.rooms[Main.currentRooms]

	for node in rooms:
		node.clearRoom()

		var cur_room = room_set[node.destination]
		var room_type = room_types[cur_room]
		node.initRoom(room_type)
	
