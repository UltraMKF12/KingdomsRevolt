extends Node2D

export(Color) var effect_color: Color
export(float, 0, 50, 0.1) var radius: float
export(float, 0, 1, 0.1) var whitening: float
export(float, 0, 5, 0.1) var effect_lenght: float

var effect_position: Vector2

func _process(delta):
	update()

func _draw():
	draw_circle(effect_position, radius, modulate)

func make_effect(new_position):
	effect_position = new_position
	modulate = effect_color
	var new_color = Color(whitening, whitening, whitening, 1)
	var tween := create_tween()
	tween.tween_property(self, "modulate", new_color, effect_lenght)
#	tween.tween_property(self, "modulate", effect_color, effect_lenght)
	tween.tween_callback(self, "queue_free")
