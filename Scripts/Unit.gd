extends KinematicBody2D
class_name Unit

export(int) var hp: int
export(int) var attack_power: int
export(int) var speed: int
export(float, 0, 2, 0.1) var attack_timer: float
export(float, 0, 2, 0.1) var invincible_timer: float

export(Array, int) var hitbox_size := [6, 7, 7, 8]
export(Array, int) var range_size := [60, 220, 160, 80]
var classes := {"sword":0, "bow":1, "mage":2, "club":3}

var team: int
var moving := false
var in_combat := false
var force_move := false

var stop_tween_timer: SceneTreeTween = null

var move_position: Vector2
var enemy: Unit

onready var range_area = $Range
onready var ranges_shape = $Range/RangeShape
onready var unit_shape = $UnitShape
onready var sprite = $Type

func _ready():
	range_check()

func _physics_process(delta):
	if(moving and not in_combat) or force_move:
		move()
	
	elif(in_combat):
		move_combat()


func set_unit(type: String, group: int):
	team = group
	sprite.animation = type
	sprite.frame = group
	add_to_group(Autoload.groups[group])
	
	#Set the group the unit is in (So the range check doesn't check for it)
	set_collision_layer_bit(group-1, true)
	range_area.set_collision_mask_bit(group-1, false)
	
	var new_shape = CircleShape2D.new()
	new_shape.radius = hitbox_size[classes[type]]
	unit_shape.shape = new_shape
	
	new_shape = CircleShape2D.new()
	new_shape.radius = range_size[classes[type]]
	ranges_shape.shape = new_shape


func select():
	sprite.modulate = Color(2, 2, 2, 1)


func unselect():
	sprite.modulate = Color(1, 1, 1, 1)


func move_order(point: Vector2):
	#To be able to move close distances
	if(stop_tween_timer != null && stop_tween_timer.is_valid()):
		stop_tween_timer.kill()
		
	moving = true
	move_position = point
	if(in_combat):
		force_move = true
		get_tree().create_tween().tween_property(self, "force_move", false, 1)


func move():
	var direction = position.direction_to(move_position)
	move_and_slide(direction * speed)


func stop(stop_timer: int):
	stop_tween_timer = create_tween()
	stop_tween_timer.tween_property(self, "moving", false, stop_timer)


func abort_stop():
	if(stop_tween_timer.is_valid()):
		stop_tween_timer.kill()
	
	
func move_combat():
	pass


func range_check():
	pass
	
	
#func hit(power: int):
#	if(not invincible):
#		hp -= power
#		if(hp <= 0):
#			queue_free()
#
#		invincible = true
#		var hit_color := Color(0.35, 0, 0, 1)
#		var tween := get_tree().create_tween()
#		tween.tween_property(self, "modulate", hit_color, invincible_timer/2)
#		tween.tween_property(self, "modulate", Color.white, invincible_timer/2)
#		tween.tween_property(self, "invincible", false, 0)
