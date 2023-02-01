extends Node2D

onready var unit = preload("res://Scenes/Unit.tscn")

func _unhandled_key_input(event):
	if event.pressed and event.scancode >= 49 and event.scancode <= 54:
		Autoload.player_group = event.scancode - 48
	
	if event.pressed and event.scancode == KEY_CONTROL:
		var new_unit = unit.instance()
		
#		var classes = ["sword", "bow", "mage", "club"]
#		var new_class = classes[randi() % classes.size()]
		var new_class = "sword"
		
		add_child(new_unit)
#		new_unit.set_unit("sword", Autoload.player_group)
		new_unit.set_unit(new_class, Autoload.player_group)
		new_unit.position = get_global_mouse_position()
