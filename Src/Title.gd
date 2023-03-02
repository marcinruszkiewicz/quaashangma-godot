extends Node2D

var cloud1:TextureRect
var cloud2:TextureRect

func _ready():
	cloud1 = get_node("clouds1")
	cloud2 = get_node("clouds2")

func _process(delta):
	cloud1.rect_global_position.x -= 10 * delta
	cloud2.rect_global_position.x -= 10 * delta
	
	if cloud1.rect_global_position.x <= -1600:
		cloud1.rect_global_position.x = cloud2.rect_global_position.x + 1600
		
	if cloud2.rect_global_position.x <= -1600:
		cloud2.rect_global_position.x = cloud1.rect_global_position.x + 1600
