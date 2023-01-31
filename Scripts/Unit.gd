extends KinematicBody2D

onready var sprite = $Type

func _ready():
	set_unit("sword", 1)


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
