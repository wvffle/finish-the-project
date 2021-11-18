extends Node2D

var time = 0
func _process(delta):
	time += delta
	if time > 3:
		if randi() % 7 == 0:
			global.stage_lost()
		else:
			global.stage_won()
