extends KinematicBody2D


export(int) var speed: int

var move: bool = false
var move_position
onready var sprite = $Type

func _ready():
#	set_unit("sword", randi() % Autoload.groups.size())
	set_unit("sword", 1)

func _process(delta):
	if move:
		var direction = position.direction_to(move_position)
		move_and_slide(direction * speed)
		if(abs(position.x - move_position.x) < 10 and abs(position.y - move_position.y) < 10):
			move = false
	

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

func move_to_point(point: Vector2):
	move_position = point
	move = true
