extends Node

export(int) var income: int
export(float, 0, 10, 0.5) var income_timer: float

func _ready():
	generate_income()


func generate_income():
	yield(get_tree().create_timer(income_timer), "timeout")
	for i in Autoload.groups.size():
		var new_income = get_tree().get_nodes_in_group(Autoload.groups[i]).size() * income
		Autoload.gold[i] += new_income
	generate_income()
