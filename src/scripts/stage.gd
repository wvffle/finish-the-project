extends Node2D


var time = 0
func _process(delta):
	if !global.paused:
		time += delta
	
	if time > global.stage_time:
		stage_lost()
		
func stage_won():
	global.stage_won(max(0, global.stage_time - time))

func stage_lost():
	global.stage_lost(max(0, global.stage_time - time))
