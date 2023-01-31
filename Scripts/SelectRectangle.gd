extends Node2D

var rectangle_start: Vector2 = Vector2.ZERO
var rectangle_end: Vector2 = Vector2.ZERO
var selecting: bool

onready var select_area = $SelectArea
onready var select_shape = $SelectArea/SelectShape

func _process(delta):
	if Input.is_action_just_pressed("mleft"):
		rectangle_start =  get_global_mouse_position()
		selecting = true
	
	if	Input.is_action_just_released("mleft"):
		selecting = false
		print(select_area.get_overlapping_bodies())
	
	update()


func _draw():
	if(selecting):
		rectangle_end = get_global_mouse_position()
		var rectangle := generate_rect()
		
		var border_color := opacity_color(Color.darkblue, 0.8)
		var fill_color := opacity_color(Color.cornflower, 0.4)
		
		draw_rect(rectangle, fill_color, true)
		draw_rect(rectangle, border_color, false, 2)
		
		select_area.position = rectangle.position + rectangle.size/2
		select_shape.shape.extents = rectangle.size/2


func generate_rect() -> Rect2:
	var rectangle := Rect2()
	rectangle.position = rectangle_start
	rectangle.size.x = abs(rectangle_start.x - rectangle_end.x)
	rectangle.size.y = abs(rectangle_start.y - rectangle_end.y)
	rectangle.end = rectangle_end
	return rectangle


func opacity_color(color: Color, opacity: float) -> Color:
	color.a = opacity
	return color
