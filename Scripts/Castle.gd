tool
extends Node2D

export(int, "None", "Dark Blue", "Red", "Orange", "Black", "Green", "Light Blue") var castle_color: int setget set_color

var groups := ["None", "Dark Blue", "Red", "Orange", "Black", "Green", "Light Blue"]


func set_color(new_value):
	castle_color = new_value
	$Sprite.frame = new_value
	
	for string in groups:
		if(is_in_group(string)):
			remove_from_group(string)
	
	add_to_group(groups[new_value])
