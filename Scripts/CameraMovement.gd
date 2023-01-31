extends Camera2D

export var world_border: Vector2
export(float, 0, 10, 0.1) var camera_speed: float

var direction: Vector2
var new_position: Vector2


func _process(_delta):
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	
	if(direction != Vector2.ZERO):
		new_position = position + (direction * camera_speed) 
		
		position.x = clamp(new_position.x, -world_border.x/4, world_border.x)
		position.y = clamp(new_position.y, -world_border.y/4, world_border.y)
	
	if Input.is_action_just_released("mwheel_up"):
		zoom.x -= 0.1
		zoom.y -= 0.1
	elif Input.is_action_just_released("mwheel_down"):
		zoom.x += 0.1
		zoom.y += 0.1
	
	zoom.x = clamp(zoom.x, 0.2, 2)
	zoom.y = clamp(zoom.y, 0.2, 2)
