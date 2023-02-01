extends Area2D

export(int) var stop_timer: int
export(int) var radius: int
#Stops the unit if it stays inside the circle for more than X seconds

func _on_StopArea_body_entered(body):
	if body.is_in_group(Autoload.groups[Autoload.player_group]):
		body.stop(stop_timer)
		
func _on_StopArea_body_exited(body):
	if body.is_in_group(Autoload.groups[Autoload.player_group]):
		body.abort_stop()
