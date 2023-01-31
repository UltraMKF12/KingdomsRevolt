extends KinematicBody2D

onready var sprite = $Type

func _ready():
	set_unit("sword", randi() % Autoload.groups.size())


func set_unit(type: String, group: int):
	sprite.animation = type
	sprite.frame = group
	add_to_group(Autoload.groups[group])
	
	match type:
		"sword":
			$SwordShape.disabled = false
		"bow":
			$BowShape.disabled = false
		"mage":
			$MageShape.disabled = false
		"club":
			$ClubShape.disabled = false


func selected():
	sprite.modulate = Color(2, 2, 2, 1)

func unselected():
	sprite.modulate = Color(1, 1, 1, 1)
