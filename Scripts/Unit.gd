extends KinematicBody2D
class_name Unit


export(int) var speed: int

var move: bool = false
var move_position: Vector2

var combat_mode: bool = false
var enemy_position: Vector2
var enemy

var attack_power: int = 1
var hp: int = 2
var invincible: bool = false
var can_attack: bool = true

var team: int

onready var Ranges = $Range
onready var sprite = $Type


func _ready():
	team = randi() % 2+1
	set_unit("sword", team)
#	set_unit("sword", randi() % Autoload.groups.size())
#	set_unit("sword", 1)


func _physics_process(delta):
	if move and not combat_mode:
		var direction = position.direction_to(move_position)
		move_and_slide(direction * speed)
		if(abs(position.x - move_position.x) < 10 and abs(position.y - move_position.y) < 10):
			move = false
	
	if combat_mode:
		#If enemy does not exist, we need to go out of combat mode
		if not is_instance_valid(enemy):
			combat_mode = false
			
		var direction = position.direction_to(enemy_position)
		move_and_slide(direction * speed)
		
		#Checks every object it interacts with, if it's and enemy attack it
		#only when none of them is invincible and this unit can attack
		for i in range(0, get_slide_count()-1):
			var item = get_slide_collision(i).collider
			if not item.is_in_group(Autoload.groups[team]):
				if(can_attack and not item.invincible and not invincible):
					item.hit(attack_power)
					can_attack = false;
					var tween := get_tree().create_tween()
					tween.tween_property(self, "can_attack", true, 0.5)
					combat_mode = false
	
	
	#Checks every object in range for an enemy. If found, initiate combat
	if not combat_mode:
		var enemy_detected := false
		var detectable = Ranges.get_overlapping_bodies()
		for item in detectable:
			if not item.is_in_group(Autoload.groups[team]):
				enemy_detected = true
				enemy = item
				combat_mode = true
				enemy_position = enemy.position



func set_unit(type: String, group: int):
	sprite.animation = type
	sprite.frame = group
	add_to_group(Autoload.groups[group])
	
	match type:
		"sword":
			$SwordShape.set_deferred("disabled", false)
			$Range/SwordRange.set_deferred("disabled", false)
			$Range/SwordRange.visible = true
		"bow":
			$BowShape.set_deferred("disabled", false)
			$Range/BowRange.set_deferred("disabled", false)
			$Range/BowRange.visible = true
		"mage":
			$MageShape.set_deferred("disabled", false)
			$Range/MageRange.set_deferred("disabled", false)
			$Range/MageRange.visible = true
		"club":
			$ClubShape.set_deferred("disabled", false)
			$Range/ClubRange.set_deferred("disabled", false)
			$Range/ClubRange.visible = true


func selected():
	sprite.modulate = Color(2, 2, 2, 1)

func unselected():
	sprite.modulate = Color(1, 1, 1, 1)

func move_to_point(point: Vector2):
	move_position = point
	move = true

func hit(power: int):
	if(not invincible):
		hp -= power
		if(hp <= 0):
			queue_free()
			
		invincible = true
		var hit_color := Color(0.35, 0, 0, 1)
		var tween := get_tree().create_tween()
		tween.tween_property(self, "modulate", hit_color, 0.25)
		tween.tween_property(self, "modulate", Color.white, 0.25)
		tween.tween_property(self, "invincible", false, 0)
