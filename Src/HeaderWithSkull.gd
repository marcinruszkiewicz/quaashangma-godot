extends NinePatchRect

export var title = "Default"

func _ready():
	var label = get_node("Label")
	label.text = title
