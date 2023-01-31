extends Node2D

export(PackedScene) var effect: PackedScene
var rectangle_start: Vector2 = Vector2.ZERO
var rectangle_end: Vector2 = Vector2.ZERO
var selecting: bool
var selected_units := []

onready var select_area = $SelectArea
onready var select_shape = $SelectArea/SelectShape

func _process(delta):
	#Mouse drag start
	if Input.is_action_just_pressed("mleft"):
		rectangle_start =  get_global_mouse_position()
		selecting = true
		unselect_units()
	
	#Mouse drag release
	if Input.is_action_just_released("mleft"):
		selecting = false
		
		#Select all player units
		var selection = select_area.get_overlapping_bodies()
		for item in selection:
			if item.is_in_group(Autoload.groups[Autoload.player_group]):
				selected_units.append(item)
		select_units()
	
	#Unit position command
	if Input.is_action_just_pressed("mright"):
		var go_position := get_global_mouse_position()
		
		var new_effect = effect.instance()
		add_child(new_effect)
		new_effect.make_effect(get_global_mouse_position())
		
		move_order(go_position)
	
	update()


#Mouse dragging
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


func unselect_units():
	for i in selected_units:
		i.unselected()
	selected_units = []


func select_units():
	for i in selected_units:
		i.selected()

func move_order(point: Vector2):
	for i in selected_units:
		i.move_to_point(point)
