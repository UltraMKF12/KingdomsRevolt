extends Label

func _process(_delta):
	text = ""
	for i in Autoload.groups.size():
		text += Autoload.groups[i] + ": " + str(Autoload.gold[i]) + "\n"
