tool
extends Node2D

export(int, "None", "Dark Blue", "Red", "Orange", "Black", "Green", "Light Blue") var castle_color: int setget set_color

func _ready():
	if not Engine.editor_hint:
		add_to_group(Autoload.groups[castle_color])


func set_color(new_value):
	castle_color = new_value
	$Sprite.frame = new_value
