extends Node2D

var click = preload("res://Assets/click1.wav")
var sound:AudioStreamPlayer
var music:AudioStreamPlayer

var settings = {
	"playSound": true,
	"playMusic": true
}

var game = {
	"maxVisitedFloor": 1,
	"HP": 20,
	"maxHP": 20,
	"gold": 0
}

var settings_save_path = "user://settings.json"
var game_save_path = "user://save.json"

var currentFloor = 1
var currentRooms = 0
var descriptions

func _ready():	
	load_settings()
	load_data()
	descriptions = read_json_file("res://Src/Text.json")
	
	sound = get_node("/root/MainScene/sound")
	music = get_node("/root/MainScene/music")
	
	if settings.playMusic:
		music.play()

func play_click():
	if settings.playSound:
		if !sound.is_playing():
			sound.stream = click
			sound.play()
		
func toggle_music():
	if settings.playMusic:
		music.play()
	else:
		music.stop()

func goto_scene(path):
	var s = ResourceLoader.load(path)
	Transitions.change_scene(s.instance(), Transitions.FadeType.CrossFade, 1)
	
func read_json_file(file_path):
	var file = File.new()
	file.open(file_path, File.READ)
	var content_as_text = file.get_as_text()
	var content_as_dictionary = parse_json(content_as_text)
	return content_as_dictionary

func save_settings():
	var file = File.new()
	file.open(settings_save_path, File.WRITE)
	file.store_line(to_json(settings))
	file.close()
	
func load_settings():
	var file = File.new()
	
	if file.file_exists(settings_save_path):
		file.open(settings_save_path, File.READ)
		var loaded = JSON.parse(file.get_as_text())
		file.close()
		
		settings = loaded.result
	
func save_data():
	var file = File.new()
	file.open(game_save_path, File.WRITE)
	file.store_line(to_json(game))
	file.close()
	
func load_data():
	var file = File.new()
	if file.file_exists(game_save_path):
		file.open(game_save_path, File.READ)
		var loaded = JSON.parse(file.get_as_text())
		file.close()
		
		game = loaded.result
