extends Area2D

var selected := false
var normal_color := Color.white
var dimmed_color := Color(0.3, 0.3, 0.3, 1)
var glow_color := Color(1.5, 1.5, 1.5, 1)
var tween: SceneTreeTween

onready var sprite = get_parent().get_node("Sprite")


func hover():
	tween = create_tween()
	tween.tween_property(sprite, "modulate", dimmed_color, 0.7)
	tween.tween_property(sprite, "modulate", glow_color, 0.7)
	tween.tween_callback(self, "hover")


func _on_Area2D_mouse_entered():
	selected = true
	hover()


func _on_Area2D_mouse_exited():
	selected = false
	tween.kill()
	sprite.modulate = normal_color
