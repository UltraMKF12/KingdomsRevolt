extends Label

var groups := ["None", "Dark Blue", "Red", "Orange", "Black", "Green", "Light Blue"]

func _process(delta: float) -> void:
	text = "None: " + str(get_tree().get_nodes_in_group(groups[0]).size()) + "\n" + \
"Dark Blue: " + str(get_tree().get_nodes_in_group(groups[1]).size()) + "\n" + \
"Red: " + str(get_tree().get_nodes_in_group(groups[2]).size()) + "\n" + \
"Orange: " + str(get_tree().get_nodes_in_group(groups[3]).size()) + "\n" + \
"Black: " + str(get_tree().get_nodes_in_group(groups[4]).size()) + "\n" + \
"Green: " + str(get_tree().get_nodes_in_group(groups[5]).size()) + "\n" + \
"Light Blue: " + str(get_tree().get_nodes_in_group(groups[6]).size())
