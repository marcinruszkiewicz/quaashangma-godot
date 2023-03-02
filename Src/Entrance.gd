extends NinePatchRect

export var title = "Default"
export var destination = 1

var image:TextureRect
var available = false

func _ready():
	var label = get_node("EntranceHeader/EntranceLabel")
	var unlabel = get_node("EntranceImage/Unavailable")
	label.text = "Floor %s" % destination
	image = get_node("EntranceImage")
	
	if Main.game.maxVisitedFloor >= destination:
		available = true
	
	if available == false:
		var button = get_node("EntranceImage/EntranceButton")
		button.disabled = true
		unlabel.text = "Unavailable\n%s/%s" % [Main.game.maxVisitedFloor, destination]
	else:
		unlabel.text = ""
	
func _on_EntranceButton_mouse_entered():
	if available:
		image.self_modulate = Color(0.9, 0.9, 0, 0.2)

func _on_EntranceButton_mouse_exited():
	if available:
		image.self_modulate = Color(1, 1, 1, 1)

func _on_EntranceButton_pressed():
	Main.currentFloor = 1;
	Main.currentRooms = 0;
	Main.play_click()
	print("clicked %s" % destination)
