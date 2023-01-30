extends Camera2D

export var world_border: Vector2
export(float, 0, 10, 0.1) var camera_speed: float

var direction: Vector2
var new_position: Vector2


func _process(delta):
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	
	if(direction != Vector2.ZERO):
		new_position = position + (direction * camera_speed) 
		print(new_position)
		
		position.x = clamp(new_position.x, 0, world_border.x)
		position.y = clamp(new_position.y, 0, world_border.y)
