extends Label

func _process(_delta):
	text = str(Autoload.groups[Autoload.player_group])
