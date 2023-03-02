extends Node2D

var HP:Label
var Gold:Label
var description:Label

func _ready():
	HP = get_node("StatsBackground/HP")
	Gold = get_node("StatsBackground/Gold")
	description = get_node("Description/Label")
	
	update_stats()
	update_description()
	
func update_stats():
	Gold.text = "Gold: %s" % Main.game.gold
	HP.text = "HP: %s/%s" % [Main.game.HP, Main.game.maxHP]

func update_description():
	var camp_description = "You rest in the Adventurer Guild Camp, restoring all your HP.\n"

	if Main.game.gold >= 15:
	  var pots = floor(Main.game.gold / 15)

	  Main.game.maxHP += pots * 5
	  Main.game.gold -= pots * 15

	  camp_description += '\nYou sell the treasures and buy %s Stamina Potions, increasing your max HP by %s.' % [pots, pots * 5]
	else:
	  camp_description += "\nYou see a Stamina Potion vendor that sells one potion for 15 gold. Not a bad price for 5 more max HP."

	description.text = camp_description;
	
