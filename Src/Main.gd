extends Node2D

var click = preload("res://Assets/click1.wav")
var sound:AudioStreamPlayer
var music:AudioStreamPlayer

var settings = {
	"playSound": true,
	"playMusic": false
}

var game = {
	"maxVisitedFloor": 1,
	"HP": 20,
	"maxHP": 20,
	"gold": 0
}

var currentFloor = 1;
var currentRooms = 0;

func _ready():	
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
