extends Node

var groups := ["None", "Dark Blue", "Red", "Orange", "Black", "Green", "Light Blue"]
var types := ["sword", "bow", "mage", "club"]
var gold := [0, 0, 0, 0, 0, 0, 0]

var player_group: int


func _process(delta):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
