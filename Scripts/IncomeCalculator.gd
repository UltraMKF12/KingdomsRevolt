extends Node

export(int) var income: int
export(float, 0, 10, 0.5) var income_timer: float

func _ready():
	generate_income()


func generate_income():
	yield(get_tree().create_timer(income_timer), "timeout")
	for i in Autoload.groups.size():
		var new_income = 0
		for item in get_tree().get_nodes_in_group(Autoload.groups[i]):
			if item is Castle:
				new_income += income
		Autoload.gold[i] += new_income
	generate_income()
