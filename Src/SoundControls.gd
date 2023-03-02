extends Control

var musicControl:CheckBox
var soundControl:CheckBox

func _ready():
	musicControl = get_node("MusicCheckbox")
	soundControl = get_node("SoundCheckbox")
	musicControl.pressed = Main.settings.playMusic
	soundControl.pressed = Main.settings.playSound
	
func _on_MusicCheckbox_pressed():
	Main.settings.playMusic = musicControl.pressed
	Main.play_click()
	Main.toggle_music()

func _on_SoundCheckbox_pressed():
	Main.settings.playSound = soundControl.pressed
	Main.play_click()
	
