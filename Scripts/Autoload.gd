extends Node

var groups := ["None", "Dark Blue", "Red", "Orange", "Black", "Green", "Light Blue"]
var gold := [0, 0, 0, 0, 0, 0, 0]

func _process(delta):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
