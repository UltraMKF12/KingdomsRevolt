extends Node2D

var rectangle_start: Vector2 = Vector2.ZERO
var rectangle_end: Vector2 = Vector2.ZERO
var selecting: bool

func _process(delta):
	if Input.is_action_just_pressed("mleft"):
		rectangle_start =  get_global_mouse_position()
		selecting = true
	
	if	Input.is_action_just_released("mleft"):
		selecting = false
	
	update()

func _draw():
	if(selecting):
		rectangle_end = get_global_mouse_position()
		var rectangle := generate_rect()
		
		var border_color := Color.darkblue
		border_color.a = 0.8
		var fill_color := Color.cornflower
		fill_color.a = 0.4
		
		draw_rect(rectangle, fill_color, true)
		draw_rect(rectangle, border_color, false, 2)


func generate_rect() -> Rect2:
	var rectangle := Rect2()
	rectangle.position = rectangle_start
	rectangle.size.x = abs(rectangle_start.x - rectangle_end.x)
	rectangle.size.y = abs(rectangle_start.y - rectangle_end.y)
	rectangle.end = rectangle_end
	return rectangle
