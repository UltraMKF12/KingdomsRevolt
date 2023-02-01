extends KinematicBody2D
class_name Unit

export(int) var hp: int
export(int) var attack_power: int
export(int) var speed: int
export(float, 0, 2, 0.1) var attack_timer: float
export(float, 0, 2, 0.1) var invincible_timer: float
export(int) var max_move_distance: int
export(int) var stop_time: int

export(Array, int) var hitbox_size := [6, 7, 7, 8]
export(Array, int) var range_size := [60, 220, 160, 80]
var classes := {"sword":0, "bow":1, "mage":2, "club":3}

var team: int
var moving := false
var in_combat := false
var force_move := false
var can_attack := true
var invincible := false

var stop_tween_timer: SceneTreeTween = null

var move_position: Vector2
var enemy: Unit

onready var range_area = $Range
onready var range_shape = $Range/RangeShape
onready var unit_shape = $UnitShape
onready var attack_area = $AttackBox
onready var attack_shape = $AttackBox/AttackShape
onready var sprite = $Type

func _ready():
	range_check()


func _physics_process(delta):
	if(moving and not in_combat) or force_move:
		if(should_unit_stop()):
			stop()
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
	attack_area.set_collision_mask_bit(group-1, false)
	
	var new_shape = CircleShape2D.new()
	new_shape.radius = hitbox_size[classes[type]]
	unit_shape.shape = new_shape
	
	new_shape = CircleShape2D.new()
	new_shape.radius = hitbox_size[classes[type]] + 1
	attack_shape.shape = new_shape
	
	new_shape = CircleShape2D.new()
	new_shape.radius = range_size[classes[type]]
	range_shape.shape = new_shape


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
		enemy = null
		get_tree().create_tween().tween_property(self, "force_move", false, 5)


func move():
	var direction = position.direction_to(move_position)
	move_and_slide(direction * speed, Vector2.ZERO, false, 2)


func stop():
	stop_tween_timer = create_tween()
	stop_tween_timer.tween_property(self, "moving", false, stop_time)


func move_combat():
	if is_instance_valid(enemy):
		var direction = position.direction_to(enemy.position)
		move_and_slide(direction * speed, Vector2.ZERO, false, 1)
		
		if can_attack:
			var enemies = attack_area.get_overlapping_bodies()
			for enemy_guy in enemies:
				if not enemy_guy.invincible:
					enemy_guy.hit(attack_power)
					can_attack = false
					get_tree().create_tween().tween_property(self, "can_attack", true, attack_timer)
					break
	else:
		in_combat = false

func range_check():
	if(not is_instance_valid(enemy)):
		var enemies = range_area.get_overlapping_bodies()
		if enemies.size() > 0:
			enemy = enemies[0]
			in_combat = true
	
	var tween := get_tree().create_tween()
	tween.tween_interval(1)
	tween.tween_callback(self, "range_check")


func should_unit_stop():
	#Only calculate value if stop_tween_timer is not yet started
	if(stop_tween_timer == null or not stop_tween_timer.is_valid()):
		var distance = position.distance_to(move_position)
		if distance <= max_move_distance:
			return true
		else:
			return false
	
	return false
	
func hit(power: int):
	if(not invincible):
		hp -= power
		if(hp <= 0):
			queue_free()

		invincible = true
		var hit_color := Color(0.35, 0, 0, 1)
		var tween := get_tree().create_tween()
		tween.tween_property(self, "modulate", hit_color, invincible_timer/2)
		tween.tween_property(self, "modulate", Color.white, invincible_timer/2)
		tween.tween_property(self, "invincible", false, 0)
